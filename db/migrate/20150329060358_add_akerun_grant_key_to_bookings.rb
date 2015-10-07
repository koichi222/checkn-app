class AddAkerunGrantKeyToBookings < ActiveRecord::Migration
  def change
    add_column :booking_rooms, :akerun_grant_key, :string, index: true
    add_column :booking_rooms, :akerun_key, :string
    add_column :bookings, :temporary_akerun_key, :string, index: true
  end
end
