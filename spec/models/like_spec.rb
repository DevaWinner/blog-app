require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Like Model Method test' do
    it 'should update likes_counter after create' do
      user = User.create(name: 'Harry')
      post = Post.create(title: 'Title', author: user)
      like = Like.create(user:, post:)

      like.update_likes_counter

      result = post.likes_counter
      expect(result).to eq(1)
    end
  end
end
