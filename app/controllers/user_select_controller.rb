class UserSelectController < ApplicationController
  def index; end

  def assign_user
    session[:user_id] = params[:user_id]
    redirect_to root_path
  end
end
