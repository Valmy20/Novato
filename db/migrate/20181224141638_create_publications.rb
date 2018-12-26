class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.string :title
      t.integer :_type
      t.text :information
      t.integer :remunaration
      t.integer :vacancies
      t.string :location
      t.string :slug
      t.boolean :deleted, default: false
      t.string :publicationable_type
      t.integer :publicationable_id

      t.timestamps
    end
  end
end
