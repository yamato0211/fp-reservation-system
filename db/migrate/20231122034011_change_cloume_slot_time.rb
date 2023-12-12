class ChangeCloumeSlotTime < ActiveRecord::Migration[7.0]
  def change
    change_column :time_slots, :start_time, :string, null: false
    remove_column :time_slots, :end_time, :string
  end
end
