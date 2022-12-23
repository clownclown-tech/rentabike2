class MessagesController < ApplicationController
  def index
    @smessages = Message.where(sender: current_user)
    @rmessages = Message.where(receiver: current_user)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    if @message.save
      redirect_to @message
    else
      render 'new'
    end
  end

  def show
    # code to retrieve the message object
    render 'show'
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_path, notice: "Message was successfully deleted."
  end


  private

  def message_params
    params.require(:message).permit(:receiver, :subject, :body)
  end
end
