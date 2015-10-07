class CreateBookingRooms < ActiveRecord::Migration
  def change
    create_table :booking_rooms do |t|
      t.references :booking
      t.references :room

      t.timestamps null: false
    end
    add_index :booking_rooms, [:booking_id, :room_id], unique: true
  end
end
