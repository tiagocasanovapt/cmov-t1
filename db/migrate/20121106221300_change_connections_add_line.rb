class ChangeConnectionsAddLine < ActiveRecord::Migration
  def up
    change_table :connections do |t|
      t.references :line
    end
  end
 
  def down
    remove_column :connections, :line_id
  end
end
