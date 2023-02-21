class UsersController < ApplicationController
  before_action :user, only: %i[ show edit update destroy ]

  def create
    @user = User.new(user_params)
    @user.uid = session_user_id

    if @user.save
      redirect_to(root_path, notice: "User was successfully created.")
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
