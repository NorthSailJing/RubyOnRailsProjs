class AddEnteredOnToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :entered_on, :date
  end
end
