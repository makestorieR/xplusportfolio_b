class AddImageUrlToSuggestions < ActiveRecord::Migration[6.0]
  def change
    add_column :suggestions, :image_url, :string
  end
end
