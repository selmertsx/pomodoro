class CreatePomodoroMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :pomodoro_memos do |t|
      t.text :memo, null: false
      t.integer :pomodoro_task_id, null: false
      t.index :pomodoro_task_id
      t.timestamps
    end
  end
end
