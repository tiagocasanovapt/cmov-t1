class ChangeTableReservations < ActiveRecord::Migration
  def up
  	remove_column :reservations, :ticket_id
  	add_column :reservations, :ticket, :string
  end

  def down
  end
end
