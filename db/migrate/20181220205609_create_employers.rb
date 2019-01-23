class CreateEmployers < ActiveRecord::Migration[5.2]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :logo
      t.string :token_reset
      t.string :slug
      t.integer :status, default: 0
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
