class AddRepuCoinToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :repu_coin, :integer, default: 100
  end
end
