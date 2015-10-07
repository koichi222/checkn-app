class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :key, unique: true
      t.references :hotel
      t.string :name
      t.string :akerun_key, unique: true

      t.timestamps null: false
    end
  end
end
