class ChangeCloumnsFinancialPlanners < ActiveRecord::Migration[7.0]
  def change
    change_column :financial_planners, :name, :string, null: false
    change_column :financial_planners, :email, :string, null: false
    change_column :financial_planners, :description, :string, null: false
    change_column :financial_planners, :qualification, :string, null: false
  end
end
