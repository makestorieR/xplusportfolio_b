class AddTypeToResources < ActiveRecord::Migration[6.0]
  def change
    add_column :resources, :resource_type, :string
  end
end
