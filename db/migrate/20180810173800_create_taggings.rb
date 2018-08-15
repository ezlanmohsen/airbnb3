class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :tagging do |t|
      t.references :listing, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
