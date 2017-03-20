class AddPpostIdAndUserIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ppost_id, :integer
    add_column :comments, :user_id, :integer
  end
end
