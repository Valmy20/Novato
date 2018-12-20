class CreateEmployerExtras < ActiveRecord::Migration[5.2]
  def change
    create_table :employer_extras do |t|
      t.text :about
      t.string :phone
      t.references :employer, foreign_key: true

      t.timestamps
    end
  end
end
