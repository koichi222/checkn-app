class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :user_requests do |t|
      t.string :key, unique: true
      t.string :agency_booking_key, index: true
      t.string :name
      t.string :email
      t.references :hotel, index: true, foreign_key: true
      t.references :travel_agency, index: true, foreign_key: true
      t.references :booking, index: true, foreign_key: true
      t.references :guest, index: true, foreign_key: true
      t.references :guest_info, index: true, foreign_key: true
      t.string :plan
      t.text :mail_note
      t.integer :count, default: 1
      t.date :date

      t.timestamps null: false
    end
    add_index :user_requests, [:key, :hotel_id]
  end
end
