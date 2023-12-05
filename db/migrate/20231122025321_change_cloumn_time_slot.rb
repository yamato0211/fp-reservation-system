class ChangeCloumnTimeSlot < ActiveRecord::Migration[7.0]
  def change
    change_column :time_slots, :is_available, :boolean, :default => true
  end
end
