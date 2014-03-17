require 'google/api_client'

CLIENT_ID = '674123074556-lpvjcp3u75tqb3javidi8sbad2rj3i0o'
CLIENT_SECRET = '8zD4YeNxtJz9uojz_6BFwU1N'
REDIRECT_URI = 'http://localhost:3000/files_sharing/omniauth_callback'
SCOPES = 'https://www.googleapis.com/auth/drive.file'

class FilesSharingController < ApplicationController
  before_filter :google_login, only: [:index, :upload]
  def index
    @result = @client.execute(api_method: @drive.files.list)
  end

  def google_login
    oauth_client
    auth_url = @client.auth_code.authorize_url(redirect_uri: REDIRECT_URI, 
      scope: SCOPES, access_type: 'offline')
    unless session[:refresh_token]
      redirect_to auth_url
    end
    if session[:refresh_token]
      auth_token = OAuth2::AccessToken.from_hash(@client,
        {:refresh_token => session[:refresh_token], :expires_at => session[:expires_at]})
      begin
        auth_token = auth_token.refresh!
      rescue
        session[:refresh_token] = nil
        session[:expires_at] = nil
        redirect_to auth_url
      end
      token = auth_token.token
      google_client(token)
    end
  end

  def omniauth_callback
    if params[:code]
      oauth_client
      auth_token = @client.auth_code.get_token(
        params[:code], :redirect_uri => REDIRECT_URI)
      session[:refresh_token]=auth_token.refresh_token
      session[:expires_at]=auth_token.expires_at
      redirect_to files_sharing_path
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
        parameters: {'uploadType' => 'multipart'})
    end
    redirect_to files_sharing_path
  end
end