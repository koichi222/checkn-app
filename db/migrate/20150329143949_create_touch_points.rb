class CreateTouchPoints < ActiveRecord::Migration
  def change
    create_table :touch_points do |t|
      t.string :key
      t.string :name
      t.references :hotel
      t.string :akerun_key, index: true
      t.string :device_type, default: 'checkin'

      t.timestamps null: false
    end
  end
end
