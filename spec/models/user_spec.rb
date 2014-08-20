require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  before(:all) do
    @user = User.new(email: "testuser@gmail.com")
  end

  it "should have many posts and should be dependent destroyed" do
    expect(User.reflect_on_association(:posts).macro).to be(:has_many)
    expect(User.reflect_on_association(:posts).options[:dependent]).to be(:destroy)
  end

  it "should have many posts" do
    expect(User.reflect_on_association(:comments).macro).to be(:has_many)
    expect(User.reflect_on_association(:comments).options[:dependent]).to be(:destroy)
  end
end
