class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|

    	t.integer :direction  # 1- ida, 2-volta
    	t.time :start_time
    	t.string :train
    	t.integer :capacity
    	t.references :line

     # t.timestamps
    end
  end
end
