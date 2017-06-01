class AddColumnToProcedures < ActiveRecord::Migration[5.1]
  def change
    add_column :procedures, :first_name, :string
    add_column :procedures, :last_name, :string
  end
end
