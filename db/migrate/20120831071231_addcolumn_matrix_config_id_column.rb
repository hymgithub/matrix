class AddcolumnMatrixConfigIdColumn < ActiveRecord::Migration
  def up
	add_column :results,:matrix_config_id,:integer
  end

  def down
  end
end
