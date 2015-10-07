class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :key, unique: true
      t.references :company
      t.string :name

      t.timestamps null: false
    end
  end
end
