class AllowProjectAnticipationsToBeNull < ActiveRecord::Migration[6.0]

  def up
  	 change_column :projects, :anticipation_id, :bigint, null: true 
  end

  def down
  	change_column :projects, :anticipation_id, :bigint, null: true 
  	 
  end
end
