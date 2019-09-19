class ChangeColumnInTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :status, :string, null: false
    change_column :tasks, :priority, :string, null: false
    change_column :tasks, :content, :string, null: false
  end
end
