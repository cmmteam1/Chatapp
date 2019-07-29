class UsersController < ApplicationController
  
  def index
    logger.debug "--------index---------"
  	@user = User.all
  end

  def show
    logger.debug "--------show---------"
     @User = User.find(params[:id])
  end

  def new
    logger.debug "--------new---------"
  	@user = User.new
  end

  def create
    logger.debug "--------create---------"
  	#render plain: params[:user].inspect
  	  @user=User.new(user_params)
  	 if @user.save  	  
        # log_in @user
  	   redirect_to root_url
       else
        render 'new'
       end  
  end

  def edit
    logger.debug "--------Edit---------"
    @user = User.find(params[:id])
    @workspace = Workspace.find(session[:current_workspace])
    @ch=Channel.where(:workspace => @workspace.id)
  end

  def update
    logger.debug "--------Update---------"
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to edit_user_path
    else
      render 'edit'
    end
  end

  private
  def user_params
   params.require(:user).permit(:name, :email, :password)
  end
end
