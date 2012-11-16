class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :value
      t.float :weight
      t.integer :parameter_id
      t.boolean :is_default
      t.integer :status
      t.references :parameter

      t.timestamps
    end
    add_index :values, :parameter_id
  end
end
