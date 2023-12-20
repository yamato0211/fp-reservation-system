class ChangeDatatypeJoinUrlOfAppointment < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :join_url, :text
  end
end
