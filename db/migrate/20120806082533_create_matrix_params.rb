class CreateMatrixParams < ActiveRecord::Migration
  def change
    create_table :matrix_params do |t|
      t.integer :matrix_config_id
      t.integer :parameter_id
      t.integer :status

      t.timestamps
    end
  end
end
