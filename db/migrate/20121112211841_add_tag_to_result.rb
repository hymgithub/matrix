class AddTagToResult < ActiveRecord::Migration
  def change
    add_column :results, :tag, :int, :default=>0
  end
end
