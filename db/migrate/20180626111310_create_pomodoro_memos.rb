class CreatePomodoroMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :pomodoro_memos do |t|
      t.text :memo
      t.integer :pomodoro_task_id

      t.timestamps
    end
  end
end
