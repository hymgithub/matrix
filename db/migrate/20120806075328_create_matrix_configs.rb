class CreateMatrixConfigs < ActiveRecord::Migration
  def change
    create_table :matrix_configs do |t|
      t.string :name
      t.integer :group_id
      t.integer :version_id
      t.integer :status

      t.timestamps
    end
  end
end
