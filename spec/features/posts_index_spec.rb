require 'rails_helper'

RSpec.feature 'Post Index', type: :feature do
  let(:user) { User.create(name: 'Tom', bio: 'Teacher from Mexico.') }
  let!(:post) { Post.create(author: user, title: "first post's title", text: 'first text') }

  before do
    user.update(photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png')
    Comment.create(author: user, post:, text: 'hello Tom')
    Comment.create(author: user, post:, text: 'Thank You Tom')
    Comment.create(author: user, post:, text: 'Good afternoon Tom')
    Like.create(user:, post:)
  end

  scenario "see user's profile picture, username, number of posts, interactions, etc." do
    visit user_posts_path(user)
    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/leaf-blue.png"]')
    expect(page).to have_content('Tom')
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content("first post's title")
    expect(page).to have_content('first text')
    expect(page).to have_content('hello Tom')
    expect(page).to have_content('Comments: 3')
    expect(page).to have_content('Likes: 1')
  end

  scenario 'asserts a section for pagination if there are more posts than fit on the view' do
    10.times do |i|
      Post.create(author: user, title: "post #{i}", text: 'text')
    end
    visit user_posts_path(user)
    expect(page).to have_selector('.pagination')
  end

  scenario "When I click on a post, it redirects me to that post's show page and I can see first comment." do
    visit user_posts_path(user)
    first('.card-body a').click

    expect(page).to have_content('hello Tom', wait: 5)
    expect(current_path).to eq user_post_path(user, post)
  end
end
