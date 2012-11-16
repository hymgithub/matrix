class ChangeColumnMatrixValuesWeight < ActiveRecord::Migration
  def up
	change_column :matrix_values,:weight, :decimal,:precision=>10, :scale=> 4
  end

  def down
  end
end
