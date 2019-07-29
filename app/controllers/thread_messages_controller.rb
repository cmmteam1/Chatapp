class ThreadMessagesController < ApplicationController

   def new
    logger.debug "--------new---------"
  	@thread=ThreadMessage.new
  end

  def create
      logger.debug "--------create---------"
  	  @thread=ThreadMessage.new(replied_msg:params[:replied_msg],message_id:params[:message_id])
      @thread.save
      @channel= Channel.find(params[:channel_id])
      redirect_to channel_path(@channel)
  end

  def destroy
    logger.debug "--------destroy---------"
    ThreadMessage.find(params[:id]).destroy
    redirect_to message_path(:message => @message_id)

 end
  private
  
   def set_channel
       @thread = ThreadMessage.find_by(params[:id])
   end
   def thread_message_params
       params.require(:thread_message).permit(:replied_msg,:message_id)
  end
end


