class RemoveUserFromChildren < ActiveRecord::Migration[8.1]
  def change
    remove_reference :children, :user, foreign_key: true
  end
end
