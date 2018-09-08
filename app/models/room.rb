require Rails.root.to_s + '/lib/google_calendar_api.rb'
class Room
  include ActiveModel::Model
  attr_accessor :id, :calendar, :connection

  def self.cache
    @@cache ||= build_rooms
  end

  def self.refresh_cache
    @@cache = build_rooms
  end

  def self.build_rooms
    all_room_calendar_ids.map { |id| Room.new(id) }
  end

  def self.first
    all.first
  end

  def self.all(refresh: false)
    refresh_cache if refresh
    cache
  end

  def self.all_ids
    all_room_calendar_ids
  end

  def self.find(id)
    case id
    when String
      new(id)
    when Array
      id.map{|id| find(id) }
    else
      raise ArgumentError.new 'find with string id or array of string ids'
    end
  end

  def initialize(id)
    @id = id
    @connection = self.class.connection
    @calendar = connection.get_calendar(id)
  end

  def events(options = {})
    start_date_time = options.fetch(:start_date_time, nil)
    end_date_time = options.fetch(:end_date_time, nil)

    # limit if no start and end date selected
    max_results = start_date_time && end_date_time ? nil : 10

    options = { max_results: max_results }
    options.merge!(time_max: end_date_time.rfc3339) if end_date_time.present?
    options.merge!(time_min: start_date_time.rfc3339) if start_date_time.present?

    items = connection.list_events(id, options).items
    events = items.map { |item| Event.new(id, item) }
    events.reject { |event| event.status == 'cancelled' }
  end

  def to_s
    "#{name} - Accomodates #{capacity}"
  end

  def name
    calendar.summary.split('38 Chauncy Street-10-').last.split('(').first.strip
  end

  def capacity
    calendar.summary.scan(/\((\d)\)/).flatten.first.to_i
  end

  def available?(start_date_time:, end_date_time:)
    events(start_date_time: start_date_time, end_date_time: end_date_time).blank?
  end

  # private

  def self.all_room_calendar_ids
    calendars = connection.list_calendar_lists
    room_calendar_list_entries = calendars.items.select{|c| c.id =~ /@resource.calendar.google.com/}
    room_calendar_list_entries.map(&:id)
  end

  def self.connection
    GoogleCalendarApi.initialize
  end
end
