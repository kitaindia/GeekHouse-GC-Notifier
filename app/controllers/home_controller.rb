class HomeController < ApplicationController
  def index
    redirect_to user_path(current_user) if current_user
    @users = User.all
  end
end