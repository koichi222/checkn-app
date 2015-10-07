class RemoveAkerunKeyFromBookingRooms < ActiveRecord::Migration
  def change
    remove_column :booking_rooms, :akerun_key, :string
  end
end
