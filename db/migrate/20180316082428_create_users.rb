class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.boolean :is_admin

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
