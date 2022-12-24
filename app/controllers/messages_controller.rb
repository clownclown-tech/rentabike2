class MessagesController < ApplicationController
  def index
    @smessages = Message.where(sender: current_user.first_name)
    @rmessages = Message.where(receiver: current_user.first_name)
  end

  def new
    @message = Message.new
    @receiver = params[:message_value]
  end

  def create
    @receiver = params[:message_value]

    #@receiver = params[:receiver]
    @message = Message.new(message_params)
    @message.sender = current_user.first_name
    if @message.save
      redirect_to messages_path, notice: "Message sent."

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
    params.require(:message).permit(:receiver, :subject, :body, :message_value)
  end
end
