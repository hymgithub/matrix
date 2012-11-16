class CreateLimitPairs < ActiveRecord::Migration
  def change
    create_table :limit_pairs do |t|
      t.integer :matrix_config_id
      t.integer :first_value_id
      t.integer :second_value_id

      t.timestamps
    end
  end
end
