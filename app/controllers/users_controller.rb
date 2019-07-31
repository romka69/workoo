class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]

  load_and_authorize_resource

  def show
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  helper_method :user
end
