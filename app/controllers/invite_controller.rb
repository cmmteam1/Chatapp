class InviteController < ApplicationController
  
  def index
    logger.info "--------index---------"
  	@users = User.where.not(id:session[:user_id])
    @workspace = Workspace.find(session[:current_workspace])
    @ch=Channel.where(:workspace => @workspace.id)
  end

  def update
    logger.info "--------update---------"
  	@invite_user = User.find(params[:id])
        @invite_channel = Channel.find(params[:channel_id])
        @is_invite = Invite.find_by(user: @invite_user, channel: @invite_channel, role: "member")
        @is_uninvite = Invite.find_by(user: @invite_user, channel: @invite_channel, role: "")
        if @is_invite.nil? && @is_uninvite.nil?
            @curr_invite = Invite.new(:user => @invite_user, :channel => @invite_channel, :role => "member")
            if @curr_invite.save
                redirect_to :action => 'index'
            end
        end

        if !@is_invite.nil?
            @is_invite.update_attribute(:role, "")
            redirect_to :action => 'index'
        end

        if !@is_uninvite.nil?
            @is_uninvite.update_attribute(:role, "member")
            redirect_to :action => 'index'
        end
  end
  private
    def invite_params
      params.require(:channel).permit(:ch_name,:status_id,:purpose,:workspace_id)
    end
end