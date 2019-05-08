class EventsController < ApplicationController
  before_action :authenticate_user!, :except=> [:index]
  before_action :get_current_event, :only=>[:show, :edit, :update, :destroy]
  attr_reader :events

  def index
    @events = Event.all
  end

  def show
    @participants = @event.participants
  end

  def new
  end

  def create
    new_event = Event.create(
      event_attributes.merge(
        admin_id: current_user.id
      )
    )

    if new_event.valid?
      flash[:success] = "Your event is created. Check it out!"
      redirect_to events_path
    else
      flash[:danger] = "Creation failed. Please try again."
      render 'new'
    end
  end

  def edit
  end

  def update
    @event.update(
      event_attributes.merge(
        admin_id: current_user.id
      )
    )

    if @event.valid?
      flash[:success] = "Event updated. Check it out!"
      redirect_to event_path(@event.id)
    else
      flash[:danger] = "Update failed. Please try again."
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event #{@id} deleted."
    redirect_to "/users/show"
  end

  private
  def event_attributes
    permitted = params.permit(:location,
    :start_time, :duration, :price, :title, :description)
  end

  def get_current_event
    @id = params[:id].to_i
    @event = Event.find(@id)
  end
end
