class CreateListingTags < ActiveRecord::Migration[5.2]
  def change
    create_table :listing_tags do |t|
      t.references :listing, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
