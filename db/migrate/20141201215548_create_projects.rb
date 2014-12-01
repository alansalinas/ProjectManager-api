class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :status
      t.integer :local_id
      t.integer :user_id
      t.integer :yearstart
      t.integer :monthstart
      t.integer :daystart
      t.integer :yeardue
      t.integer :monthdue
      t.integer :daydue
      t.integer :opentasks
      t.integer :totaltasks
      t.string :contentpath

      t.timestamps
    end
  end
end
