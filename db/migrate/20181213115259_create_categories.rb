class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.boolean :status
      t.boolean :deleted, default: false
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
