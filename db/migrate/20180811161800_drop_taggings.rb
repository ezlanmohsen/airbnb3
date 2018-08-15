class DropTaggings < ActiveRecord::Migration[5.2]
  def change
  	drop_table :tagging
  end
end
