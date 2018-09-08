class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
   @room = Room.new(resource_params)

    if @room.save
      redirect_to @room
    else
      render "new"
    end
  end

  def update
    if @room.update_attributes(resource_params)
      redirect_to @room
    else
      render "new"
    end
  end

  def destroy
    if @room.destroy
      render "index"
    else
      redirect_to @room
    end
  end

private

  def resource_params
    params[:room].permit(:name, :capacity)
  end
end
