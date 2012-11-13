class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|

    	t.string :name
    	t.integer :totalTime

    	t.references :first_station
    	t.references :last_station

     # t.timestamps
    end
  end
end
