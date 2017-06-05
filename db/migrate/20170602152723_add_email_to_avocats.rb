class AddEmailToAvocats < ActiveRecord::Migration[5.1]
  def change
    add_column :avocats, :email, :string
  end
end
