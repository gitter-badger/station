class CreateStationCaches < ActiveRecord::Migration[5.0]
  def change
    create_table :station_caches do |t|
      t.string :key, index: true
      t.string :value
      t.timestamp :triggered_time
      t.timestamps null: false
    end
  end
end
