class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.datetime :start
      t.datetime :end

      t.references :user, index: true
      t.references :room, index: true
      t.timestamps
    end
  end
end
