class CreateUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :units do |t|
      t.integer :unit_number
      t.string :unit_address
      t.string :unit_type
      t.string :storey
      t.string :tenure
      t.string :floor_size
      t.string :land_size
      t.integer :washroom
      t.integer :bedroom
      t.string :username
      t.string :password_digest
      t.string :tenant_name
      t.string :tenant_phone_number
      t.string :tenant_email
      t.timestamps
    end
  end
end
