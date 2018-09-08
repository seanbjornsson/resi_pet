class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new

    @rooms = Room.all.collect {|p| [ p.name, p.id ] }
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
   @event = Event.new(resource_params)

    if @event.save
      redirect_to @event
    else
      @rooms = Room.all.collect {|p| [ p.name, p.id ] }

      render "new"
    end
  end

  def update
    if @event.update_attributes(resource_params)
      redirect_to @event
    else
      @rooms = Room.all.collect {|p| [ p.name, p.id ] }

      render "new"
    end
  end

  def destroy
    if @event.destroy
      render "index"
    else
      redirect_to @event
    end
  end

private

  def resource_params
    params[:event].permit(:start_datetime, :end_datetime, :room_id)
  end
end
