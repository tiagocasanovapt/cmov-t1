class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      	t.time :stop_time
    	t.references :station
    	t.references :path
     # t.timestamps
    end
  end
end
