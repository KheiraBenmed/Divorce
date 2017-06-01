class AddCoordinatesToAvocats < ActiveRecord::Migration[5.1]
  def change
    add_column :avocats, :latitude, :float
    add_column :avocats, :longitude, :float
  end
end
