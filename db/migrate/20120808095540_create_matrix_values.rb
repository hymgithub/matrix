class CreateMatrixValues < ActiveRecord::Migration
  def change
    create_table :matrix_values do |t|
      t.integer :matrix_param_id
      t.integer :value_id
      t.integer :weight
      t.boolean :is_chosen
      t.integer :status

      t.timestamps
    end
  end
end
