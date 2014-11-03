class MessagesController < ApplicationController
  def inbox
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

    params[:message][:recipients].shift #the first element from multiselect is always nil
    found_users = User.find(params[:message][:recipients])
    @message.recipients << found_users if found_users


    if @message.save
      redirect_to inbox_path
      flash[:success] = "Your message has been sent"
    else
      render 'new'
    end
  end

  def outbox
    @messages = Message.outbox(current_user)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
