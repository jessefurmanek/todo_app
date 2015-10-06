class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
    	t.belongs_to :user, index: true
    	t.string :task
    	t.integer :complete, :boolean
    	t.date :due_date
      t.timestamps null: false
    end
  end
end
