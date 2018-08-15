class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.timestamps null: false
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.string :address_1, null: false
      t.string :address_2, null: false
      t.integer :postcode, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.integer :bedroom
      t.integer :bed
      t.integer :bathroom
      t.string :space
      t.integer :max_guest, null: false
      t.integer :max_price, null: false
      t.integer :min_price, null: false
    end
  end
end
