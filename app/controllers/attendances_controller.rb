class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @event = Event.find(params[:event_id])
  end

end
