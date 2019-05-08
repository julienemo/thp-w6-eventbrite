class AttendancesController < ApplicationController
  before_action :authenticate_user!, :get_current_event
  attr_accessor :user, :event

  def index
    @attendances = @event.attendances
  end

  def new
    @user = current_user
    @event = Event.find(params[:event_id])
  end

  def create
    ####histoire de params permit
    new_attendance = Attendance.new()
    if new_attendance
      flash[:success] =
      "Payment succeeded. You're now officially on the guest list!"
      redirect_to "/events/#{@event.id}"
    else
      flash[:danger] =
      "Oups, we couldn't debit the card. Mind trying again?"
      render 'new'
    end
  end

  private
  def get_current_event
    @event = Event.find(params[:event_id])
  end
end
