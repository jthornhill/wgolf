class AddLoginKeyToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :login_key, :uuid
  end
end
