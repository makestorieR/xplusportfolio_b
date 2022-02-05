class AddNameToAnticipationCovers < ActiveRecord::Migration[6.0]
  def change
    add_column :anticipation_covers, :name, :string
  end
end
