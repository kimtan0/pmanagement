class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :due
      t.references :unit, foreign_key: true
      t.timestamps
    end
  end
end
