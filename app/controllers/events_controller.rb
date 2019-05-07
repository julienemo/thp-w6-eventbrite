class EventsController < ApplicationController
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


end
