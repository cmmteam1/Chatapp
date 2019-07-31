class UsersController < ApplicationController
  
  def index
    logger.info "--------index---------"
  	@user = User.all
  end

  def show
    logger.info "--------show---------"
     @User = User.find(params[:id])
  end

  def new
    logger.info "--------new---------"
  	@user = User.new
  end

  def create
    logger.info "--------create---------"
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
    logger.info "--------Edit---------"
    @user = User.find(params[:id])
    @workspace = Workspace.find(session[:current_workspace])
    @ch=Channel.where(:workspace => @workspace.id)
  end

  def update
    logger.info "--------Update---------"
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
