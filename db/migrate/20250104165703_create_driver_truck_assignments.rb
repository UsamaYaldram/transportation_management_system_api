class CreateDriverTruckAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :driver_truck_assignments do |t|
      t.references :driver, null: false, foreign_key: true
      t.references :truck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
