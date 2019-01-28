class AddNameForSearchToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name_for_search, :string
  end
end
