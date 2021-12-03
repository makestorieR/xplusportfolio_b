class AddLikeesCountToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :likees_count, :integer, :default => 0
  end
end
