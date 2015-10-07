class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :key, unique: true
      t.references :travel_agency
      t.references :hotel
      t.references :guest_info
      t.string :plan
      t.datetime :checkin
      t.datetime :checkout
      t.string :no
      t.string :status

      t.timestamps null: false
    end
  end
end
