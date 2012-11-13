class ChangePrice < ActiveRecord::Migration
  change_table :prices do |t|  
  		t.change :price, :decimal, {:precision => 8, :scale => 4}
  end
end
