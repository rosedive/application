class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.string :content
      t.integer :prior, default: 0
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
