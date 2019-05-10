class EventsController < ApplicationController
  #before_action :authenticate_user!, :except=> [:index]
  before_action :get_current_event, :only=>[:show, :edit, :update, :destroy]
  attr_reader :events


  def index
    @events = Event.all
  end

  def show
    if !@event.validated && current_user!=@event.admin
      flash[:danger]="Naaaaa, can't access to this event."
      redirect_to events_path
    elsif !@event.validated && current_user==@event.admin
      flash.now[:success]="Your event is waiting for validation. It is not visible to other users yet."
    end
    @participants = @event.participants
  end

  def new
  end

  def create
    if !new_event.valid?
      flash[:danger] = "Event creation failed, please try again."
      render 'new'
    elsif !event_photo.present?
      flash[:danger] = "Please do upload a photo. I insist."
      render 'new'
    elsif !attach_photo(new_event)
      flash[:danger] = "Couldn't attach photo. Please do go to editing page and try again."
      redirect_to edit_event_path(new_event.id)
    else
      flash[:success] = "Event created. It'll appear here once validated by a wise person!"
      redirect_to events_path
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

    if !@event.valid?
      flash[:danger] = "Update failed. Please try again."
      render 'edit'
    elsif event_photo.present? && !attach_photo(@event)
      flash[:danger] = "Event info update but couldn't upload photo. Please try again."
      render 'edit'
    else
      flash[:success] = "Event updated. Check it out!"
      redirect_to event_path(@event.id)
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event #{@id} deleted."
    redirect_to "/users/show"
  end

  private

  def event_photo
    params.permit(:photo)[:photo]
  end

  # note how this method is call 3 times in #new
  # it used to be a good old Event.create
  # the thing is...it's called 3 times
  # which means #new creates 3 times a new event...
  # now it is @event = || var
  # which means if @event is already defined
  # return @event and ignore whatever follows
  # otherwise, assign var value to @event
  def new_event
    @event ||= Event.create(
        event_attributes.merge(
          admin_id: current_user.id
        )
      )
  end

  def event_attributes
    permitted = params.permit(:location,
    :start_time, :duration, :price, :title, :description)
  end

  def attach_photo(event)
    event.photo.attach(event_photo)
    event.photo.attached?
  end

  def get_current_event
    @id = params[:id].to_i
    @event = Event.find(@id)
  rescue
    flash[:danger] ="Naaaaa, this event doesn't exist...."
    redirect_to events_path
  end

end
