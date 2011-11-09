class ChangesRideLengthToDistance < ActiveRecord::Migration
  def up
    rename_column :rides, :length, :distance
  end

  def down
    rename_column :rides, :distance, :length
  end
end
