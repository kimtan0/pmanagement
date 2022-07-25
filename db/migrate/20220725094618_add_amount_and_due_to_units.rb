class AddAmountAndDueToUnits < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :rental_amount, :integer
    add_column :units, :due_amount, :integer
  end
end
