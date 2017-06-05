class RenameFirstNameInProcedures < ActiveRecord::Migration[5.1]
  def change
    rename_column :procedures, :first_name, :full_name
    remove_column :procedures, :last_name, :string
  end
end
