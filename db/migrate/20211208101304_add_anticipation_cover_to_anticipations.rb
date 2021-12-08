class AddAnticipationCoverToAnticipations < ActiveRecord::Migration[6.0]
  def change
    add_reference :anticipations, :anticipation_cover, null: true, foreign_key: true
  end
end
