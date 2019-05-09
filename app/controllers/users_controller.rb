class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def index
  end

  def update
    if !current_user.update(user_attributes)
      flash[:danger] = "Info upload failed. Please try again."
      render 'edit'
    elsif user_avatar.present? && !attach_avatar
      flash[:danger] = "Photo upload failed but we managed to update other info. Please try again."
      render 'edit'
    else
      flash[:success] = "Profile updated. Check it out!"
      redirect_to user_path(current_user.id)
    end
  end

  private

  def attach_avatar
    current_user.avatar.attach(user_avatar)
    current_user.avatar.attached?
  end

  def user_attributes
    params.permit(:first_name,
    :last_name, :description)
  end

  def user_avatar
    params.permit(:avatar)[:avatar]
  end
end
