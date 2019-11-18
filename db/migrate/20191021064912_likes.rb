class Likes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
    end
    add_index :likes, [:user_id, :review_id], unique: true
  end
end
