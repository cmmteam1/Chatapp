class MessagesController < ApplicationController

  def index
    logger.info "--------index---------"
  	@message=Message.all
  	
  end

  def show
    logger.info "--------show---------"
    @message=Message.all
  end

  def new
    logger.info "--------new---------"
    @message=Message.new
  end

  def create
    logger.info "--------create---------"
    @message = Message.new(content:params[:content],channel_id:params[:channel_id], user_id:current_user.id, star_msg:params[:star_msg],attached_file:params[:attached_file],unread_msg:params[:unread_msg])
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.js
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logger.info "--------destroy---------#{session[:curr_channel_id]}"
    Message.find(params[:id]).destroy
    @channel=Channel.find(session[:curr_channel_id])
    redirect_to channel_path(@channel)
  end

  def message_params
    params.require(:message).permit(:content, :star_msg, :attached_file, :unread_msg, :channel_id,:user_id)

  end


end
