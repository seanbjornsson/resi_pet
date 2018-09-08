class Event
  # validates :room_available?

  attr_accessor :room_id, :google_calendar_event

  delegate :attendees,
    :created,
    :creator,
    :end,
    :etag,
    :html_link,
    :i_cal_uid,
    :id,
    :kind,
    :location,
    :organizer,
    :reminders,
    :sequence,
    :start,
    :status,
    :summary,
    :updated, to: :google_calendar_event

  # validates :name, presence: true

  # validate :valid_start_datetime_and_end_datetime
  # validate :no_event_overlap

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
    "#{name}: #{start_datetime.strftime('%l:%M')}-#{end_datetime.strftime('%l:%M')} <=> Room: #{room}"
  end

  def initialize(room_id, google_calendar_event)
    @room_id = room_id
    @google_calendar_event = google_calendar_event
  end

  def start_date_time
    google_calendar_event.start.date_time
  end

  def end_date_time
    google_calendar_event.end.date_time
  end
end
