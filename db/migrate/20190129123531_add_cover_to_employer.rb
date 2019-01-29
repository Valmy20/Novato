class AddCoverToEmployer < ActiveRecord::Migration[5.2]
  def change
    add_column :employers, :cover, :string
  end
end
