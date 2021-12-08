class CreateAnticipationCovers < ActiveRecord::Migration[6.0]
  def change
    create_table :anticipation_covers do |t|
      t.string :image

      t.timestamps
    end
  end
end
