class MessagesController < ApplicationController
  def index

  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to messages_path
      flash[:success] = "Your message has been sent"
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:created_by_id, :body)
  end
end
