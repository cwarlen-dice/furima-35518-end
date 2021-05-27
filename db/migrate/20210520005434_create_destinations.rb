class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.string :postal_code, null: true
      t.integer :prefecture_id, null: true
      t.string :city, null: true
      t.string :addresses, null: true
      t.string :building
      t.string :phone_number, null: true
      t.references :order, null: true, foreign_key: true
      t.timestamps
    end
  end
end
