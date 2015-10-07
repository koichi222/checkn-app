class CreateTravelAgencies < ActiveRecord::Migration
  def change
    create_table :travel_agencies do |t|
      t.string :key, unique: true
      t.string :name
      t.integer :order_index, unique: true

      t.timestamps null: false
    end
  end
end
