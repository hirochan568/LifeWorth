class MessagesController < ApplicationController

  def index
   @message = Message.new
   @user = current_user
   @messages = @user.messages
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if  @message.save
      flash[:success] = 'Post is complete！Please wait for a while until the administrator responds.'
      redirect_to messages_path(current_user)
    else
      @user = current_user
      @messages = @user.messages
      render :index
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      flash[:success] = "You have destroyed message successfully."
      @user = @message.user
      redirect_to messages_path(current_user)
    else
      @user = current_user
      @messages = @user.messages
      render :index
    end
  end


  private

  def message_params
    params.require(:message).permit(:title, :body)
  end

end
