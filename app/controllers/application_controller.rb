class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    before_action :current_user
    
    
    private
  

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  
  
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end


end
