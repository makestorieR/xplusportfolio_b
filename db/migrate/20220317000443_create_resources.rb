class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :link
      t.string :color
      t.string :img_url
      t.string :desc

      t.timestamps
    end
  end
end
