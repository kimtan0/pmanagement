class CreateComplaints < ActiveRecord::Migration[6.1]
  def change
    create_table :complaints do |t|
      t.string :description
      t.references :unit, foreign_key: true
      t.timestamps
    end
  end
end
