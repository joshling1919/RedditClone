class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :comment_id
      t.timestamps null: false
    end
    add_index :comments, [:user_id, :post_id, :comment_id]
  end
end