class AddArchiveToProcedures < ActiveRecord::Migration[5.1]
  def change
    add_column :procedures, :archive, :string
  end
end
