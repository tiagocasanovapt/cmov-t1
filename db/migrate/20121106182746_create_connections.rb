class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|

    	t.references :first_station
    	t.references :last_station

    	t.integer :order_num
    	t.integer :distance
     # t.timestamps
    end
  end
end
