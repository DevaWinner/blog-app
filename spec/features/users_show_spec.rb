require 'rails_helper'

RSpec.feature 'User Show', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png', bio: 'This is a bio fro random user') }
  let!(:post1) { Post.create(author: user, title: 'Post 1', text: 'first text') }
  let!(:post2) { Post.create(author: user, title: 'Post 2', text: 'second text') }
  let!(:post3) { Post.create(author: user, title: 'Post 3', text: 'third text') }

  before do
    visit user_path(user)
  end

  scenario 'visiting the user Show page' do
    expect(page).to have_content('Tom')
    expect(page).to have_content('Bio')
    expect(page).to have_content('This is a bio fro random user')
    expect(page).to have_link('See All Posts')
  end

  scenario 'asserts you can see the user\'s profile picture' do
    expect(page).to have_selector('img[src="https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png"]')
  end

  scenario 'asserts you can see the user\'s first 3 posts' do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
  end

  scenario 'asserts you can see the number of posts the user has written' do
    expect(page).to have_content('3 Posts')
  end
end

RSpec.feature 'User Show', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://picsum.photos/id/7/200', bio: 'This is a bio fro random user') }
  let!(:post1) { Post.create(author: user, title: 'Post title 1', text: 'first text') }
  let!(:post2) { Post.create(author: user, title: 'Post title 2', text: 'second text') }
  let!(:post3) { Post.create(author: user, title: 'Post title 3', text: 'third text') }

  before do
    visit user_path(user)
  end

  scenario 'redirects to the post show page when you click on a users post' do
    click_link 'Post title 1'
    expect(current_path).to eq(user_post_path(user, post1))
  end

  scenario 'redirects to the users posts index page when you click on "See all posts"' do
    click_link 'See All Posts'
    expected_path = user_posts_path(user).chomp('/')
    actual_path = page.current_path.chomp('/')
    expect(actual_path).to eq(expected_path)
  end
end
