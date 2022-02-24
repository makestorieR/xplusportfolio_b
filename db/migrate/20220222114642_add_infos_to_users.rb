class AddInfosToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :website_url, :string
    add_column :users, :linkedin_url, :string
    add_column :users, :github_url, :string
    add_column :users, :about, :string
    add_column :users, :backcover_imgurl, :string
  end
end
