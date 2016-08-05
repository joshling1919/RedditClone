class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.text :description
      t.timestamps null: false
    end
    add_index :subs, :user_id
  end
end
