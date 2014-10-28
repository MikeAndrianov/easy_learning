class MessagesController < ApplicationController
  def index
    @messages = current_user.inbox
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new
    @message.sender = current_user
    @message.body = params[:message][:body]

    found_user = User.find(params[:message][:recipients].to_i)
      if found_user
        @message.recipients << found_user
      end

    if @message.save
      redirect_to messages_path
      flash[:success] = "Your message has been sent"
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipients, :body)
  end
end
