class AddCloumnTimeSlot < ActiveRecord::Migration[7.0]
  def change
    add_column :time_slots, :is_available, :boolean, :default => false
  end
end
