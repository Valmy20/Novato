class CreateEmployers < ActiveRecord::Migration[5.2]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :logo
      t.string :token_reset
      t.string :slug
      t.integer :status
      t.boolean :deleted

      t.timestamps
    end
  end
end
