class CalendarController < ApplicationController

  def index
  end

  def day
    @events = Event.all
  end

  def week
    @events = Event.all
  end
end
