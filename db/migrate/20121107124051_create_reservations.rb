class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|

      t.references :user
      t.references :path 
      t.references :first_station
      t.references :last_station
      t.date :reserv_date
      t.boolean :paid, :default => false
      t.references :ticket

     # t.timestamps
    end
  end
end
