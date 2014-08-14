class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.string :string
      t.references :user, index: true

      t.timestamps
    end
  end
end
