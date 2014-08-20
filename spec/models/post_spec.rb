require 'rails_helper'

RSpec.describe Post, :type => :model do
  before(:each) do
    DatabaseCleaner.start
    @user.save
    (1..5).each do |s|
      @post = @user.posts.build
      @post.content = "test content #{s}"
      @post.save
    end

  end

  after(:each) do
    DatabaseCleaner.clean
  end

  before(:all) do
    @user = User.new(email: "testuser@gmail.com")
  end

  it "should belong to a user" do
    expect(Post.reflect_on_association(:user).macro).to be(:belongs_to)
  end

  it "should have many comments" do
    expect(Post.reflect_on_association(:comments).macro).to be(:has_many)
    expect(Post.reflect_on_association(:comments).options[:dependent]).to be(:destroy)
  end

  context "test for scopes" do
    it "should give the latest posts" do
      expect(Post.latest(3)).to eq(Post.order('created_at DESC').limit(3))
    end
  end
end