require Rails.root.to_s + '/lib/google_calendar_api.rb'
class Room
  attr_accessor :id, :calendar, :connection

  def to_s
    "#{name} - Accomodates #{capacity}"
  end

  def self.first
    all.first
  end

  def self.all
    ids = all_room_calendar_ids
    ids.map { |id| Room.new(id) }
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
    max_results = options.fetch(:max_results, 10)
    # raise 'Please filter room events by date' unless start_date && end_date

    items = connection.list_events(id, max_results: max_results).items
    items.map { |item| Event.new(id, item) }
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
