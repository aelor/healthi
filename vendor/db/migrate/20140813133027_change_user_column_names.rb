class ChangeUserColumnNames < ActiveRecord::Migration
  def change
    rename_column :users, :password, :password_hash
    rename_column :users, :string, :password_salt
  end
end
