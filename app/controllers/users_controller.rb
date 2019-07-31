class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]

  load_and_authorize_resource

  def show
  end

  def edit
  end

  def update
    if user.update(user_params)
      redirect_to user, notice: 'Профиль обновлен'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :city, :birth_date, :about)
  end

  def user
    @user ||= User.find(params[:id])
  end

  helper_method :user
end
