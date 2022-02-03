class AddTextColorCodeToAnticipationCovers < ActiveRecord::Migration[6.0]
  def change
    add_column :anticipation_covers, :text_color, :string
  end
end
