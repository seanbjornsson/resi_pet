class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime     :start_datetime
      t.datetime     :end_datetime

      t.belongs_to   :room
    end
  end
end
