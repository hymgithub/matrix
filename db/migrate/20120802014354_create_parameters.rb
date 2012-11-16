class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string :name
      t.float :weight
      t.boolean :is_default
      t.integer :status

      t.timestamps
    end
  end
end
