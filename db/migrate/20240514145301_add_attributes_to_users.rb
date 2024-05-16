class AddAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :number_of_children, :integer
    add_column :users, :years_experience, :integer
    add_column :users, :pay, :integer
    add_column :users, :bio, :text
  end
end
