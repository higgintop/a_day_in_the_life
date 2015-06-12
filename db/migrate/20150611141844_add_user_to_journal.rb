class AddUserToJournal < ActiveRecord::Migration
  def change
    add_reference :journals, :user, index: true, foreign_key: true
  end
end
