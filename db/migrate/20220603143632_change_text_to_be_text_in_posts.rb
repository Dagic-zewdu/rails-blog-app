class ChangeTextToBeTextInPosts < ActiveRecord::Migration[7.0]
   def up
    change_column :posts, :text, :string
   end

  def down
    change_column :posts, :text, :text
  end
end
