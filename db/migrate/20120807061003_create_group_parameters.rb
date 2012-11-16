class CreateGroupParameters < ActiveRecord::Migration
  def change
    create_table :group_parameters do |t|
      t.integer :group_id
      t.string :parameter_id
      t.integer :status

      t.timestamps
    end
  end
end
