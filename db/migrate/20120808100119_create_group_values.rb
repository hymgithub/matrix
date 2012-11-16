class CreateGroupValues < ActiveRecord::Migration
  def change
    create_table :group_values do |t|
      t.integer :group_id
      t.integer :value_id
      t.integer :status

      t.timestamps
    end
  end
end
