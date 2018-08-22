class UsersController < ApplicationController
  def new
    @user = User.new(user_params.merge({sub: session[:openid_subject]}))
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.permit(:name, :preferred_username)
  end
end
