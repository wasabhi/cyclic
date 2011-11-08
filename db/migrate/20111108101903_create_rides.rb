class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :name
      t.boolean :favourite
      t.decimal :length
      t.date :date
      t.references :user

      t.timestamps
    end
  end
end
