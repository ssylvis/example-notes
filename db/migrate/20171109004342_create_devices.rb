class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_uid, null: false
      t.timestamp :last_heartbeat
      t.timestamps
    end
  end
end
