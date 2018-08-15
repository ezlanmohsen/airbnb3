class AddVerifiedToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :verified, :integer, default: 0
  end
end