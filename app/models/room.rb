class Room < ActiveRecord::Base
  validates :capacity, presence: true

  has_many :events

  def to_s
    "#{name} - Accomodates #{capacity}"
  end
end
