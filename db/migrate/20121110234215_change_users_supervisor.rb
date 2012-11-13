class ChangeUsersSupervisor < ActiveRecord::Migration
  def up
  	add_column :users, :supervisor, :boolean, :default => false
  end

  def down
  end
end
