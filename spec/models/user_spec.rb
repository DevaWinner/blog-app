require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom') }

  describe 'User Model Name validation tests' do
    it 'should have name present' do
      subject.name = 'Tom'
      expect(subject).to be_valid
    end

    it 'should not have name field empty, if then' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'User Model counter validation tests' do
    it 'posts_counter must be an integer otherwise' do
      subject.posts_counter = 'You are not an integer'
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to zero' do
      subject.posts_counter = -2
      expect(subject).to_not be_valid

      subject.posts_counter = 0
      expect(subject).to be_valid

      subject.posts_counter = 2
      expect(subject).to be_valid
    end
  end

  describe 'User Model Method test' do
    it 'should return three most recent posts' do
      user = User.create(name: 'Harry')
      Post.create(title: 'Title0', author: user, created_at: 5.day.ago)
      Post.create(title: 'Title1', author: user, created_at: 4.day.ago)
      post2 = Post.create(title: 'Title2', author: user, created_at: 3.day.ago)
      post3 = Post.create(title: 'Title3', author: user, created_at: 2.day.ago)
      post4 = Post.create(title: 'Title4', author: user, created_at: 1.day.ago)
      expect(user.three_most_recent_posts).to eq([post4, post3, post2])
    end
  end
end
