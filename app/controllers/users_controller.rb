class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes.includes(:user)
  end
end

#@nickname = current_user.nickname
#@tweets = current_user.tweets
