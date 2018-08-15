class FixColumnNameInListings < ActiveRecord::Migration[5.0]
  def change
    rename_column :listings, :verified, :verification_status
  end
end