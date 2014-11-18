class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.integer :local_id
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end