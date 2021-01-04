class RenameTaskCompletedToStatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :completed, :status
    change_column :tasks, :status, :integer, using: 'status::integer'
  end
end
