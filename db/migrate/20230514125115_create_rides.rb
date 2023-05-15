class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.point :start_location
      t.point :end_location
      t.datetime :start_time
      t.datetime :end_time
      t.references :rider, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
