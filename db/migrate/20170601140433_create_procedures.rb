class CreateProcedures < ActiveRecord::Migration[5.1]
  def change
    create_table :procedures do |t|
      t.integer :child_nb
      t.integer :owner_nb
      t.integer :renter_nb
      t.string :status_pro
      t.integer :bank_account_nb
      t.integer :credit_nb
      t.integer :insurance_nb
      t.integer :vehicle_nb
      t.string :contract_type
      t.string :status_pro_conjoint
      t.boolean :marriage_contract
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
