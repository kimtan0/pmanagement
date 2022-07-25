class AddUserTypeToUnit < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :user_type, :string
  end
end
