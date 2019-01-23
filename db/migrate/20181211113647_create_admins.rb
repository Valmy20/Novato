class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :token_reset
      t.boolean :status, default: true
      t.boolean :deleted, default: false
      t.integer :rules, default: 1

      t.timestamps
    end
  end
end
