class AddVideoUrlToResources < ActiveRecord::Migration[6.0]
  def change
    add_column :resources, :video_url, :string
  end
end
