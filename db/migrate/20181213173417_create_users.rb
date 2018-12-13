class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :avatar
      t.string :cover
      t.string :uid
      t.integer :status
      t.string :provider
      t.string :token_reset
      t.json :credentials
      t.string :slug
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
