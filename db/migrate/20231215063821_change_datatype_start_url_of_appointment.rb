class ChangeDatatypeStartUrlOfAppointment < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :start_url, :text
  end
end
