class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include PicturesHelper
  include TagsHelper

  def check_loggedin
    if not logged_in?
      flash[:danger] = 'You are not logged in'
      redirect_to root_url
    end
  end
end
