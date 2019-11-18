class Comments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :comment_id
      t.string :comment_type
      t.string :content
      t.integer :parent_id, default: "0"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
