class SessionController < ApplicationController

 def index
 end

 def new
 end

 def log_in(user)
     session[:user_id] = user.id
 end

 def current_user
     if session[:user_id]
       @current_user ||= User.find_by(id: session[:user_id])
     end
 end

 def current_ch
     if session[:user_id]
       @current_ws ||= User.find_by(id: session[:user_id]).workspaces
       @current_ch ||= Workspace.find_by(id: @current_ws.id).channels
     end
 end

 def create
        logger.info "--------login---------"
        if params[:session][:email].blank? && params[:session][:password].present?
            redirect(t('emailnecessary'))
         elsif params[:session][:email].present? && params[:session][:password].blank?
            redirect(t('passwordnecessary'))
         elsif params[:session][:email].blank? && params[:session][:password].blank?
            redirect(t('emailpasswordness'))
         else
            user = User.find_by(email: params[:session][:email])
             if user.present?
                if user && user.authenticate(params[:session][:password])
                     session[:user_id]= user.id
                   # redirect_to :controller => 'workspaces', :action => 'index'
                     redirect_to controller: 'workspaces', action: 'new', id: session[:user_id]
                else
                 redirect(t('unknown'))
               end
           end
        end
 end

 def redirect(alert)
     redirect_to login_path(params[:redirect_url].present? ? {:redirect_url => params[:redirect_url]} : {}), :alert => alert
 end

 def destroy
   session[:user_id] = nil
     redirect_to root_url, notice: "Logged out!"
 end
end