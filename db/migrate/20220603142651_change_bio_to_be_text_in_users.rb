class ChangeBioToBeTextInUsers < ActiveRecord::Migration[7.0]
   def up
    change_column :users, :bio, :string
   end
  def down
    change_column :users, :bio, :text
  end
end
