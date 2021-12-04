class RemoveLikeesFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :likees_count
  end
end
