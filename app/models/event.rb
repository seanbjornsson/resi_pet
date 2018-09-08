class Event < ActiveRecord::Base
  belongs_to :room

  validates :name, presence: true

  validate :room_available?

  validate :valid_start_datetime_and_end_datetime
  validate :no_event_overlap

  def room_available?
    return true
  end

  def valid_start_datetime_and_end_datetime
    return true
  end

  def no_event_overlap
    return true
  end

  def to_s
    "#{name}: #{start_datetime.strftime('%l:%M')}-#{end_datetime.strftime('%l:%M')}"
  end
end
