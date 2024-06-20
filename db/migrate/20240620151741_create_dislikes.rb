class CreateDislikes < ActiveRecord::Migration[7.1]
  def change
    create_table :dislikes do |t|
      t.references :user
      t.integer :disliked_user_id
      t.timestamps
    end
  end
end
