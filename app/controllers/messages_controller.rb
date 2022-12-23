class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
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
    params.require(:message).permit(:subject, :body)
  end
end
