class AddColumnsToFinancialPlanner < ActiveRecord::Migration[7.0]
  def change
    add_column :financial_planners, :name, :string, :limit => 20
    add_column :financial_planners, :description, :string, :limit => 400
    add_column :financial_planners, :qualification, :string, :limit => 100
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
