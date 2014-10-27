class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :password
      t.integer :proyectos

      t.timestamps
    end
  end
end
