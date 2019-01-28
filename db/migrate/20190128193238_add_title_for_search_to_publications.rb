class AddTitleForSearchToPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :title_for_search, :string
  end
end
