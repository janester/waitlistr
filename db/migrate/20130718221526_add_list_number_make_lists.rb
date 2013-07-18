class AddListNumberMakeLists < ActiveRecord::Migration
  def change
    add_column :users, :position, :integer
    create_table :lists
  end
end
