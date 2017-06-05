class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :user, foreign_key: true
      t.references :avocat, foreign_key: true
      t.references :procedure, foreign_key: true

      t.timestamps
    end
  end
end
