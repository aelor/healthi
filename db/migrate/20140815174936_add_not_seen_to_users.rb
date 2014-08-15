class AddNotSeenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :not_seen, :string
  end
end
