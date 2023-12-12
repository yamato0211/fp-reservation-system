class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :financial_planner, null: false, foreign_key: true
      t.references :time_slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
