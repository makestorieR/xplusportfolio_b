class AddEditedToSuggestions < ActiveRecord::Migration[6.0]
  def change
    add_column :suggestions, :edited, :boolean
  end
end
