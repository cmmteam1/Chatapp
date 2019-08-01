class ChannelsController < ApplicationController
 before_action :set_channel, only: [:show, :edit, :update, :destroy]
 def index
  logger.info "--------index---------"
   @channel= Channel.all
   @workspace = Workspace.all
   @workspace = Workspace.find(session[:current_workspace])
       @ch=Channel.where(:workspace => @workspace.id)
    render action: :index
 end

 def new
  logger.info "--------new---------" 
  @channel= Channel.new
  @workspace = Workspace.find(session[:current_workspace])
 end

  def create
     logger.info "--------create---------"
     @channel= Channel.new(ch_name:params[:ch_name],status_id:params[:status_id],purpose:params[:purpose],workspace_id:params[:workspace_id])
     @workspace = Workspace.find(params[:workspace_id])
     if @channel.save
      
     @current=Channel.last
     @currentchannel=Invite.create(:user => current_user, :channel => @channel, :role => "owner")
     @currentchannel.save
     redirect_to workspace_path(@workspace.id)
    else
      render 'new'
       @workspace = Workspace.find(session[:current_workspace])
       @ch=Channel.where(:workspace => @workspace.id)
     end
  end

 def show
  logger.info "--------show---------"
    @channel = Channel.find(params[:id])
    @message=Message.new
    @messages=Message.all.includes(:user).where(:channel => @channel.id)
    @thread=ThreadMessage.new
    @threads=ThreadMessage.all
    @workspace =Workspace.find(session[:current_workspace])
    @ch=Channel.where(:workspace => @workspace.id)
    session[:channel_list]=@channel.id
    helpers.set_channel @channel
    helpers.set_message @message
   end


  def edit

  end

 def update
  logger.info "--------update---------"
  
   if @channel.update_attributes(channel_params)
     redirect_to channel_path, notice: 'Channnel was successfully update'
   else
     render action: :edit
   end
end

  def destroy
    logger.info "--------destroy---------"
    Channel.find(params[:id]).destroy 
    @workspace = Workspace.find(session[:current_workspace])
    redirect_to workspace_path(@workspace)
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
