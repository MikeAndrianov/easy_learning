require 'google/api_client'

CLIENT_ID = '674123074556-lpvjcp3u75tqb3javidi8sbad2rj3i0o'
CLIENT_SECRET = '8zD4YeNxtJz9uojz_6BFwU1N'
REDIRECT_URI = 'http://localhost:3000/files/omniauth_callback'
SCOPES = 'https://www.googleapis.com/auth/drive.file'

class FilesController < ApplicationController
  before_filter :google_login, only: [:index, :upload]
  before_filter :set_the_header

  def index
    @files = GoogleFile.all
  end

  def google_login
    oauth_client
    auth_url = @client.auth_code.authorize_url(redirect_uri: REDIRECT_URI, 
      scope: SCOPES, access_type: 'offline')
    if current_user.google_refresh_token
      auth_token = OAuth2::AccessToken.from_hash(@client,
        {:refresh_token => current_user.google_refresh_token, :expires_at => current_user.google_expires_at})
      begin
        auth_token = auth_token.refresh!
      rescue
        set_credentials(nil, nil)
        redirect_to auth_url
      end
      token = auth_token.token
      google_client(token)
    else
      redirect_to auth_url
    end
  end

  def omniauth_callback
    if params[:code]
      oauth_client
      auth_token = @client.auth_code.get_token(
        params[:code], :redirect_uri => REDIRECT_URI)
      set_credentials(auth_token.refresh_token, auth_token.expires_at)
      redirect_to files_path
    end
  end

  def google_client(token)
    @client = Google::APIClient.new
    @client.authorization.client_id = CLIENT_ID
    @client.authorization.client_secret = CLIENT_SECRET
    @client.authorization.redirect_uri = REDIRECT_URI
    @client.authorization.scope = SCOPES
    @client.authorization.access_token = token
    @drive = @client.discovered_api('drive', 'v2')
  end

  def oauth_client
    @client = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET,
      site: "https://accounts.google.com",
      token_url: "/o/oauth2/token",
      authorize_url: "/o/oauth2/auth")
  end

  def upload
    if params[:upload]
      data = params[:upload][:file]  
      file = Google::APIClient::UploadIO.new(data.path, data.content_type)
      metadata = {title: data.original_filename}
      @result = @client.execute(
        api_method: @drive.files.insert,
        body_object: metadata,
        media: file,
        parameters: {'uploadType' => 'multipart', convert: true})
      google_file = GoogleFile.create(name: data.original_filename, google_id: @result.data.alternateLink, 
        uploaded_by: current_user.name)
      share_file
    end
    redirect_to files_path
  end

  def share_file
    file_id = @result.data.id
    permission = {role: 'reader', type: 'anyone'}
    result = @client.execute(
      api_method: @drive.permissions.insert,
      body_object: permission,
      parameters: {fileId: file_id})
  end

  def set_credentials(token, expires)
    current_user.update_attributes(google_refresh_token: token)
    current_user.update_attributes(google_expires_at: expires)
  end

  private

  def set_the_header
    @the_header = :files
  end

end