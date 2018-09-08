class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
   @event = Event.new(resource_params)

    if @event.save
      redirect_to @event
    else
      render "new"
    end
  end

  def update
    if @event.update_attributes(resource_params)
      redirect_to @event
    else
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
    params[:event].permit(:start_datetime, :end_datetime, :room)
  end
end

end
