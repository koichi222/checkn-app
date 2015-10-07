class AddSomeColumns < ActiveRecord::Migration
  def change
    add_column :hotels, :akerun_hotel_key, :string
    add_column :bookings, :agency_booking_key, :string
    add_index :bookings, [:agency_booking_key, :hotel_id, :travel_agency_id], name: "booking1"
    remove_column :user_requests, :agency_booking_key, :string
    remove_column :user_requests, :date, :date
    remove_column :user_requests, :plan, :string
    remove_column :user_requests, :hotel_id, :integer rescue nil
    remove_column :user_requests, :travel_agency_id, :integer rescue nil
  end
end
