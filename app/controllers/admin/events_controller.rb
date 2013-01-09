class Admin::EventsController < ApplicationController
  def index
    @events = Event.where(:deleted => false).order("weight DESC")
  end

  def weight_move
    current = Event.find(params[:id])
    if params[:up].to_i == 1
      if current != Event.order("weight DESC").first
        switch = Event.where("weight > #{current.weight} AND deleted = 0").order("weight ASC").first
        current_weight = current.weight
        current.weight = switch.weight
        switch.weight = current_weight
        switch.save
        current.save
      end
    else
      if current != Event.order("weight DESC").last
        switch = Event.where("weight < #{current.weight} AND deleted = 0").order("weight DESC").first
        current_weight = current.weight
        current.weight = switch.weight
        switch.weight = current_weight
        switch.save
        current.save
      end
    end
    redirect_to admin_events_path
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
    @last_weight = Event.order("weight DESC").first.weight
    @last_weight ||= 0 
    @event.weight = 1 + @last_weight
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
    @event = Event.find(params[:id])
    @event.deleted = 1
    @event.save
    redirect_to admin_events_path
  end
end
