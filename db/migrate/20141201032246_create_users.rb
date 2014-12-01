class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :password
      t.string :email
      t.string :auth_token
      t.integer :request_pass

      t.timestamps
    end
  end
end
