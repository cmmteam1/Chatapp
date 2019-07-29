class ChannelsController < ApplicationController
 before_action :set_channel, only: [:show, :edit, :update, :destroy]
 def index
  logger.debug "--------index---------"
   @channel= Channel.all
   @workspace = Workspace.all
    render action: :index
 end

 def new
  logger.debug "--------new---------" 
  @channel= Channel.new
  @workspace = Workspace.find(session[:current_workspace])
  @ch=Channel.where(:workspace => @workspace.id)
  @channels=Channel.all
 end

  def create
     logger.debug "--------create---------"
     @channel= Channel.new(ch_name:params[:ch_name],status_id:params[:status_id],purpose:params[:purpose],workspace_id:params[:workspace_id])
     @workspace = Workspace.find(params[:workspace_id])
     if @channel.save
     @current=Channel.last
     @currentchannel=Invite.create(:user => current_user, :channel => @channel, :role => "owner")
     @currentchannel.save
     # @channel.save
     # @user_channel = Invite.new(:new => session[:user_id], :channel => @channel, :role => "owner")
     # @user_channel.save
        
     redirect_to workspace_path(@workspace.id)
    else
      render 'new'
    end
  end

 def show
  logger.debug "--------show---------"
    @channel = Channel.find(params[:id])
    @message=Message.new
    @messages=Message.all.includes(:user).where(:channel => @channel.id)
    # @messages=Message.where(:channel => @channel.id)
    @thread=ThreadMessage.new
    @threads=ThreadMessage.where(session[:curr_message_id])
    @workspace = Workspace.find(session[:current_workspace])
    @ch=Channel.where(:workspace => @workspace.id)
    # session[:channel_list]=@channel.id
    helpers.set_channel @channel
    helpers.set_message @message
   end


  def edit
    # @workspace = Workspace.find(params[:id])
      @workspace = Workspace.find(session[:current_workspace])
      @ch=Channel.where(:workspace => @workspace.id)
  end

 def update
  logger.debug "--------update---------"
   if @channel.update_attributes(channel_params)
     redirect_to channel_path, notice: 'Channnel was successfully update'
   else
     render action: :edit
   end
end

  def destroy
    logger.debug "--------destroy---------"
    Channel.find(params[:id]).destroy 
    
    redirect_to workspace_path
  end

  def current_workspace
   #@workspaces = Workspace.find(params[:id])
  end
  
 private
     # Use callbacks to share common setup or constraints between actions.
  def set_channel
       @channel = Channel.find(params[:id])
  end
  # we used strong parameters for the validation of params
  def channel_params
   params.require(:channel).permit(:ch_name,:status_id,:purpose,:workspace_id)
  end
end
