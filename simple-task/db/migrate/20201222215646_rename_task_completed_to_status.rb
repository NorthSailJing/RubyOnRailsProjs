class RenameTaskCompletedToStatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :completed, :status
    change_column :tasks, :status, :integer
  end
end
