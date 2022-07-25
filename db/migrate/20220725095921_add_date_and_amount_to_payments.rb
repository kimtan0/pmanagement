class AddDateAndAmountToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :date, :date
    add_column :payments, :amount, :integer
  end
end
