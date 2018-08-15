class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
    	t.references :listing, foreign_key: true
      	t.references :user, foreign_key: true
      	t.date :check_in_date
      	t.date :check_out_date
      	t.integer :status, :default => 0 #to use enum in model - [booked, accepted, completed]
      t.timestamps
    end
  end
end
