class Ratings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true
      t.integer :rating_value

      t.timestamps
    end
    add_index :ratings, [:user_id, :updated_at]
    add_index :ratings, [:tour_id, :updated_at]
  end
end
