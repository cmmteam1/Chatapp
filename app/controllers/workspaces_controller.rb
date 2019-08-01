class WorkspacesController < ApplicationController
 before_action :set_workspace, only: [:show, :edit, :update, :destroy]

 def index
  logger.info "--------index---------"
   @workspace = Workspace.all
   @workspacelist = User.all.find_by(id:session[:user_id]).workspace
 end

 def new
  logger.info "--------new---------"
    @workspace=Workspace.new
    @workspacelist = User.all.find_by(id:session[:user_id]).workspace
 end

 def create
    logger.info "--------create---------"
    @workspace =Workspace.new(workspace_params)
   if @workspace.save
    @current=Workspace.last
    @currentWorkspace= Userwork.new(user_id:session[:user_id], workspace_id:@current.id)
    @currentWorkspace.save
    session[:current_workspace]=@workspace.id
     redirect_to @workspace
   else
    render 'new'
  end
 end

 def show
  logger.info "--------show---------"
   @userworkspace =  Userwork.find_by(workspace_id: @workspace.id) 
   @workspace = Workspace.find(params[:id])
   @ch=Channel.where(:workspace => @workspace.id)
  session[:current_workspace]=@workspace.id
 end

 def edit
    # @workspace = Workspace.find(params[:id])
 end

 def update
    logger.info "--------update---------"
       @workspace = Workspace.find(params[:id])
      if @workspace.update(workspace_params)
       @userworkspace =  Userwork.find_by(workspace_id: @workspace.id)
       @ch=Channel.where(:workspace => @workspace.id)

       # @userworkspace.update_attribute(:workspace_name, @workspace.workspace_name)
       redirect_to workspace_path
      else
      flash[:danger] = "Update is not success."
      render "edit"
    end
 end

 def destroy
  logger.info "--------delete---------"
    Workspace.find(params[:id]).destroy
    redirect_to new_workspace_path
 end
  
 private

 def set_workspace
    @workspace = Workspace.find(params[:id])
 end

 def workspace_params
   params.require(:workspace).permit(:workspace_name)
 end

 def userwork_params
   params.require(:userwork).permit(:user_id,:workspace_id,:role)
 end

end