class CreateLinesStationsTable < ActiveRecord::Migration
  def up
    create_table :lines_stations, :id => false do |t|
        t.references :line
        t.references :station
    end
    add_index :lines_stations, [:line_id, :station_id]
  end

  def down
  	drop_table :lines_stations
  end
end