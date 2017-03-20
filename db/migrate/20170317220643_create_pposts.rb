class CreatePposts < ActiveRecord::Migration
  def change
    create_table :pposts do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
