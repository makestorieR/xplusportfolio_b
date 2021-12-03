class CreateAnticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :anticipations do |t|
      t.string :body
      t.date :due_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
