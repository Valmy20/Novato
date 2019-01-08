class CreateInstitutionExtras < ActiveRecord::Migration[5.2]
  def change
    create_table :institution_extras do |t|
      t.text :about
      t.string :phone
      t.string :location
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
