class MessagesController < ApplicationController
  def index
    @messages = Message.inbox(current_user)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user


    found_user = User.find(params[:message][:recipients])
    @message.recipients << found_user if found_user


    if @message.save
      redirect_to messages_path
      flash[:success] = "Your message has been sent"
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
