class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :card_type, :null => false #dropdown list - mastercard + visa + ...
      t.string :number, :limit => 16, :null => false
      t.integer :ccv, :limit => 3, :null => false
      t.date :expiration, :null => false

      t.references :user

     # t.timestamps
    end
  end
end
