class CreateTimeSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :time_slots do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.references :financial_planner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
