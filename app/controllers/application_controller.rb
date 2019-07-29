class ApplicationController < ActionController::Base
   
	before_action :set_locale
	helper_method :current_user
    def current_user
    	if session[:user_id]
      		@current_user ||= User.find(session[:user_id])
    	else
        	@current_user = nil
    	end
    end

    def set_locale
    	I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options
    	{ locale: I18n.locale }
    end

end
