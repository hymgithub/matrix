class RenameMatrixParamsIdColumn < ActiveRecord::Migration
  def up
	rename_column :results,:matrix_params_id,:matrix_param_id
  end

  def down
  end
end
