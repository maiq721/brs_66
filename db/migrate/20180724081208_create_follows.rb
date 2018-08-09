class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.string :type
      t.integer :follower_id

      t.timestamps
    end
    add_index :follows, :follower_id
    add_index :follows, [:user_id, :follower_id], unique: true
  end
end
