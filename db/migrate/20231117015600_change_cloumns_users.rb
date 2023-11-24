class ChangeCloumnsUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :name, :string, null: false, presence: true, length: { minimum: 1, maximum: 20 }
    change_column :users, :email, :string, null: false, presence: true
    change_column :users, :description, :string, null: false, presence: true, length: { minimum: 1, maximum: 400 }
  end
end
