class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :likes, :liked_account_id, :liked_user_id
  end
end
