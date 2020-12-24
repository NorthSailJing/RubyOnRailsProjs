class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.string :client
      t.integer :duration
      t.boolean :completed
      
      t.timestamps
    end
  end
end
