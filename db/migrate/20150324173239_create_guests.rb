class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :key, unique: true
      t.string :akerun_user_key, unique: true

      t.timestamps null: false
    end
  end
end
