class RemoveUserColumn < ActiveRecord::Migration
  def change
    remove_column :entries, :user
  end
end
