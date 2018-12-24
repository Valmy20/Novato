class AddLocationToEmployerExtras < ActiveRecord::Migration[5.2]
  def change
    add_column :employer_extras, :location, :string
  end
end
