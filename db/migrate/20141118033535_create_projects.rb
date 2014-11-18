class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :status
      t.integer :local_id
      t.integer :user_id

      t.timestamps
    end
  end
end
