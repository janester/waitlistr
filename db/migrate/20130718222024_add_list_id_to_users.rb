class AddListIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :list_id, :integer
  end
end
