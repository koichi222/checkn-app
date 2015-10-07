class AddGuestToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :guest, index: true, foreign_key: true
  end
end
