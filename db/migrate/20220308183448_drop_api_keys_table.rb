class DropApiKeysTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :api_keys
  end
end
