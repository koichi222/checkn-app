class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :key, unique: true
      t.string :name

      t.timestamps null: false
    end
  end
end
