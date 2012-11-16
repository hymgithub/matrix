class RenameHasChoseColumn < ActiveRecord::Migration
  def up
	rename_column :results,:is_chose,:has_chosen
  end

  def down
  end
end
