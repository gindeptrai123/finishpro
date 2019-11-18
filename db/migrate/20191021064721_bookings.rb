class Bookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
        t.string :name
        t.integer :phone
        t.integer :status, default: "0"
        t.float :price
        t.datetime :date_in
        t.datetime :date_out
        t.references :user, foreign_key: true
        t.references :tour, foreign_key: true

        t.timestamps
    end
    add_index :bookings, [:user_id, :created_at]
    add_index :bookings, [:tour_id, :created_at]
  end
end
