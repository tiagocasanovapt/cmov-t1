class ChangeReservationValid < ActiveRecord::Migration
  def up
  	add_column :reservations, :verified, :boolean, :default => false
  end

  def down
  end
end
