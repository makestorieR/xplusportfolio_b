class CreateTools < ActiveRecord::Migration[6.0]
  def change
    create_table :tools do |t|
      t.references :technology, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
