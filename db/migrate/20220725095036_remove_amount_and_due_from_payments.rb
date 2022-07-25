class RemoveAmountAndDueFromPayments < ActiveRecord::Migration[6.1]
  def change
    remove_column :payments, :amount
    remove_column :payments, :due
  end
end
