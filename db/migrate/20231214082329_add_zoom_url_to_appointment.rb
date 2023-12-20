class AddZoomUrlToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :join_url, :string, null: true
    add_column :appointments, :start_url, :string, null: true
  end
end
