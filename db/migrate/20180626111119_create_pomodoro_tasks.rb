class CreatePomodoroTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :pomodoro_tasks do |t|
      t.string :objective, null: false
      t.integer :user_id, null: false
      t.index :user_id
      t.timestamps
    end
  end
end
