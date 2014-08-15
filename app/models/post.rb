class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy

  scope :latest, -> (num){ order('created_at DESC').limit(num) }
end
