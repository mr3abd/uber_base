class CreateCabs < ActiveRecord::Migration[7.0]
  def change
    create_table :cabs do |t|
      t.string :license_plate
      t.string :make
      t.string :model
      t.integer :year
      t.point :location
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
