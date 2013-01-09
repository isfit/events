class Admin::EventsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    @event = Event.new(params[:event])
    @event.deleted = false
    @event.weight = Event.order("weight DESC").first.weight + 1
    if @event.save
      redirect_to admin_event_path(@event), notice: "Event was successfully created."
    else
      render action: "new"
    end
  end

  def new
    @event = Event.new
    @event_types = EventType.all
    @event_places = EventPlace.all
  end

  def destroy
  end
end
