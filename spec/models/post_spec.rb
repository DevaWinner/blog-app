require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Title', author: User.create(name: 'Dick')) }

  describe 'Post Model title validation tests' do
    it 'should have title present' do
      subject.title = 'Title'
      expect(subject).to be_valid
    end

    it 'should not have title field empty, if then' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should be less than or equal to 250 characters' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid

      subject.title = 'a' * 250
      expect(subject).to be_valid
    end
  end

  describe 'Post Model counter validation tests' do
    it 'comments_counter must be an integer otherwise' do
      subject.comments_counter = 'You are not an integer'
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = -2
      expect(subject).to_not be_valid
    end

    it 'likes_counter must be an integer otherwise' do
      subject.likes_counter = 'You are not an integer'
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to zero' do
      subject.likes_counter = -2
      expect(subject).to_not be_valid
    end
  end

  describe 'Post Model Method test' do
    it 'should update posts_counter after create' do
      user = User.create(name: 'Harry')
      Post.create(title: 'Title', author: user)
      expect(user.posts_counter).to eq(1)
    end

    it 'should return five most recent comments' do
      user = User.create(name: 'Harry')
      Comment.create(author: user, post: subject, text: 'comment 1', created_at: 5.day.ago)
      comment1 = Comment.create(author: user, post: subject, text: 'comment 2', created_at: 4.day.ago)
      comment2 = Comment.create(author: user, post: subject, text: 'comment 3', created_at: 3.day.ago)
      comment3 = Comment.create(author: user, post: subject, text: 'comment 4', created_at: 2.day.ago)
      comment4 = Comment.create(author: user, post: subject, text: 'comment 5', created_at: 1.day.ago)
      comment5 = Comment.create(author: user, post: subject, text: 'comment 6', created_at: Time.now)

      result = subject.five_most_recent_comments
      expect(result).to eq([comment5, comment4, comment3, comment2, comment1])
    end
  end
end
