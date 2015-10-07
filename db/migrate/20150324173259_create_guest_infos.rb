class CreateGuestInfos < ActiveRecord::Migration
  def change
    create_table :guest_infos do |t|
      t.string :key, unique: true
      t.references :guest
      t.string :name
      t.string :zip
      t.string :address1
      t.string :address2
      t.string :phone
      t.string :email
      t.string :sex
      t.string :receipt_name

      t.timestamps null: false
    end
  end
end
