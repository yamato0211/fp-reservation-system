class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, :limit => 20
    add_column :users, :description, :string, :limit => 400
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
