class EventsController < ApplicationController
  before_action :authenticate_user!, :except=> [:index]
  attr_reader :events

  def index
    @events = Event.all
  end

  def show
    @id = params[:id].to_i
    @event = Event.find(@id)
  end

  def new
  end

  def create
    permitted = params.permit(:location,
    :start_time, :duration, :price, :title, :description)

    new_event = Event.create(location: permitted[:location],
    start_time: permitted[:start_time],
    duration: permitted[:duration],
    admin_id: current_user.id,
    title: permitted[:title],
    description: permitted[:description],
    price: permitted[:price])

    if new_event.valid?
      flash[:success] = "Your event is created. Check it out!"
      redirect_to '/'
    else
      flash[:danger] = "Creation failed. Please try again."
      render 'new'
    end
  end


end
