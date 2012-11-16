class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :matrix_params_id
      t.integer :value_id
      t.boolean :is_chose
      t.integer :sort_id

      t.timestamps
    end
  end
end
