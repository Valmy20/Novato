class CreateEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :email
      t.string :entityable_type
      t.integer :entityable_id
      t.boolean :deleted, default: false

      t.timestamps
    end
    add_index :entities, [:entityable_type, :entityable_id]
  end
end
