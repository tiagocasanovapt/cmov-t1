class Price < ActiveRecord::Migration
 def change
    create_table :prices do |t|

    	t.decimal :price, :precision => 8, :scale => 2
    end
  end
end
