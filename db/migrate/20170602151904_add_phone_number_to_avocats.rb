class AddPhoneNumberToAvocats < ActiveRecord::Migration[5.1]
  def change
    add_column :avocats, :phone_number, :string
  end
end
