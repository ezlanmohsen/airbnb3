class ChangeListings < ActiveRecord::Migration[5.2]
  def up
	change_column :listings, :bedroom, :integer, :default => 1
	change_column :listings, :bed, :integer, :default => 1
	change_column :listings, :bathroom, :integer, :default => 1
  end
end
