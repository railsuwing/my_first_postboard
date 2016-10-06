class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #logged_in?方法沒宣告為helper_method的話，就只能在控制器中
  #  使用。如果想要在視圖中使用此方法可以將它宣告為helper_method，
  #  這樣所有的視圖就都可以直接使用這個方法。
  helper_method :current_user, :logged_in? 

  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
