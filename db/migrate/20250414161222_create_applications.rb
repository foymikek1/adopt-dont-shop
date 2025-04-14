class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :description
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
