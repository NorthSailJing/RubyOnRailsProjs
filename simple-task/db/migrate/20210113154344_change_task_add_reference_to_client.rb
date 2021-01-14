class ChangeTaskAddReferenceToClient < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :client, :string
    add_column :tasks, :client_id, :integer, references: :client
  end
end
