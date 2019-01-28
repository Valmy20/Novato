class AddNameForSearchToSkill < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :name_for_search, :string
  end
end
