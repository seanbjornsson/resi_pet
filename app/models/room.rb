class Room < ActiveRecord::Base
  validates :capacity, presence: true

  has_many :events
end
