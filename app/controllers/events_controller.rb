class EventsController < ApplicationController
  #before_action :authenticate_user!, :except=> [:index]
  before_action :get_current_event, :only=>[:show, :edit, :update, :destroy]
  attr_reader :events


  def index
    @events = Event.all.order(:id)
  end

  def show
    if !@event.validated
      flash[:danger]="Naaaaa, can't access to this event."
      redirect_to events_path
    else
      @participants = @event.participants
    end
  end

  def new
  end

  def create
    puts "$"*60
    p event_photo
    puts "$"*60
    p  event_attributes
    puts "$"*60
    p params
    puts "$"*60

    if !new_event.valid?
      flash[:danger] = "Event creation failed, please try again."
      render 'new'
    elsif !event_photo.present?
      flash[:danger] = "Please do upload a photo. I insist."
      render 'new'
    #elsif !attach_photo(new_event)
    #  flash[:danger] = "Couldn't attach photo. Please do go to editing page and try again."
    #  redirect_to edit_event_path(new_event.id)
    else
      flash[:success] = "Perfect, one event created. Check it out!"
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

  def event_photo
    params.permit(:photo)[:photo]
  end

  def new_event
    new_event = Event.create(
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
    id = params[:id].to_i
    @event = Event.find(id)
  rescue
    flash[:danger] ="Naaaaa, this event doesn't exist...."
    redirect_to events_path
  end

end
