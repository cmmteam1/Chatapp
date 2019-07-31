class UserworkController < ApplicationController
  def index
    logger.info "--------index---------"
  	 @users = User.where.not(id: current_user).order(:name).page(params[:page]).per(5)
     @workspace = Workspace.find(session[:current_workspace])
     @ch=Channel.where(:workspace => @workspace.id)
  end

  def update
    logger.info "--------update---------"
  	@invite_user = User.find(params[:id])
        @invite_workspace = Workspace.find(params[:workspace_id])
        @is_invite = Userwork.find_by(user: @invite_user, workspace: @invite_workspace, role: "member")
        @is_uninvite = Userwork.find_by(user: @invite_user, workspace: @invite_workspace, role: "")
        if @is_invite.nil? && @is_uninvite.nil?
            @curr_invite = Userwork.new(:user => @invite_user, :workspace => @invite_workspace, :role => "member")
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

