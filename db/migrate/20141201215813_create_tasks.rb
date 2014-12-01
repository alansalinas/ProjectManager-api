class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.integer :local_id
      t.integer :user_id
      t.integer :project_id
      t.string :priority
      t.integer :percentage
      t.integer :yearstart
      t.integer :monthstart
      t.integer :daystart
      t.integer :yeardue
      t.integer :monthdue
      t.integer :daydue
      t.string :photopath
      t.string :description
      t.string :contentpath

      t.timestamps
    end
  end
end
