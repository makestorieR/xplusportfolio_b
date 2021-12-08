class AddSlugToAnticipations < ActiveRecord::Migration[6.0]
  def change
    add_column :anticipations, :slug, :string
    add_index :anticipations, :slug, unique: true
  end
end
