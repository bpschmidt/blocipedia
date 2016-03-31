class UsersController < ApplicationController
  def index
    if params[:user_id]
    @posts = Post.where(user_id: params[:user_id])
  else
    @posts = Post.all
  end
  end

  def show
    authorize current_user

  end
end
