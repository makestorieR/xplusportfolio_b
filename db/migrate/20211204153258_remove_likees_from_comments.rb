class RemoveLikeesFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :likees_count
  end
end
