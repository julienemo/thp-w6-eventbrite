class AttendancesController < ApplicationController
  before_action :authenticate_user!, :get_current_event
  attr_accessor :user, :event

  def index
    @attendances = @event.attendances
  end

  def new
    @user = current_user
  end

  def create
    new_attendance = Attendance.create(event_id: @event.id, participant_id: current_user.id)
    if new_attendance
      flash[:success] =
      "You're now officially on the guest list!"
      redirect_to "/events/#{@event.id}"
    else
      flash[:danger] =
      "Oups, we couldn't make it. Mind trying again?"
      render 'new'
    end
  end

  private
  def get_current_event
    @event = Event.find(params[:event_id])
  end
end
