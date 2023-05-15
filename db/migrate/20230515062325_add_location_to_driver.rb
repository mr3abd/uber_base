class AddLocationToDriver < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :location, :point
  end
end
