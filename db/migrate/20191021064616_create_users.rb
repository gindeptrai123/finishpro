class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.integer :role, default: 1
      t.boolean :gender, default: true

      t.timestamps
    end
  end
end
