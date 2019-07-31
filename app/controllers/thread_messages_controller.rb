class ThreadMessagesController < ApplicationController

  def new
    logger.info "--------new---------"
  	@thread=ThreadMessage.new
  end

  def create
      logger.info "--------create---------"
  	  @thread=ThreadMessage.new(replied_msg:params[:replied_msg],message_id:params[:message_id])
      @thread.save
      @channel= Channel.find(params[:channel_id])
      redirect_to channel_path(@channel)
  end

  def destroy
    logger.info "--------destroy---------"
    ThreadMessage.find(params[:id]).destroy
    @channel=Channel.find(session[:curr_channel_id])
    redirect_to channel_path(@channel)
  end
  private
  
  def set_channel
     @thread = ThreadMessage.find_by(params[:id])
  end

  def thread_message_params
       params.require(:thread_message).permit(:replied_msg,:message_id)
  end
end


