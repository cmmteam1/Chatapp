class ApplicationController < ActionController::Base
    include SessionHelper
	before_action :set_locale
	helper_method :current_user

    def set_locale
    	I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options
    	{ locale: I18n.locale }
    end

end
