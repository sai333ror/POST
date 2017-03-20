class AddUserIdToPposts < ActiveRecord::Migration
  def change
    add_column :pposts, :user_id, :integer
  end
end
