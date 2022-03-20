class CreateBackgroundCoverPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :background_cover_photos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :img_url

      t.timestamps
    end
  end
end
