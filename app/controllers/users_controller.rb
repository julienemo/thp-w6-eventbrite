class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def index
  end

  def update
    # validation "a la prefecture"
    # check for the most common error and stops
    # which means in ours case, if the info such as name etc are not good
    # we return an error and don't even try to attach the photo....
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

  # so that I don't type all the attributes in the update parameter
  def user_attributes
    params.permit(:first_name,
    :last_name, :description)
  end

  # note this is not a hash but a....an element
  # coz this method will be used to the .attach method
  # which doesn't work on a hash
  def user_avatar
    params.permit(:avatar)[:avatar]
  end

  def attach_avatar

    current_user.avatar.attach(user_avatar)
    current_user.avatar.attached?
  end
end
