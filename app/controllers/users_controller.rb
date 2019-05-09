class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def index
  end

  def update
    current_user.update(user_attributes)
    if current_user.valid?
      flash[:success] = "Profile updated. Check it out!"
      redirect_to user_path(current_user.id)
    else
      flash[:danger] = "Update failed. Please try again."
      render 'edit'
    end
  end

  private
  def user_attributes
    permitted = params.permit(:first_name,
    :last_name, :description)
  end
end
