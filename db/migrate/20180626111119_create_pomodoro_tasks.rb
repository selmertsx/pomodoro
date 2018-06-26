class CreatePomodoroTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :pomodoro_tasks do |t|
      t.string :objective
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
