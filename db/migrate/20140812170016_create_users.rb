class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :string
      t.string :email
      t.string :password
      t.string :string

      t.timestamps
    end
  end
end
