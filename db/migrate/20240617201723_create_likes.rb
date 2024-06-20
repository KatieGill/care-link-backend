class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user
      t.integer :liked_account_id
      t.timestamps
    end
  end
end
