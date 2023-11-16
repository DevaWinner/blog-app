require 'rails_helper'

RSpec.feature 'Post Show', type: :feature do
  let(:user) { User.create(name: 'Tom', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Post Title', text: 'Post Text') }

# Add here

  scenario "I can see the post's title, author, comments_counter, likes_counter, body, commentors name, " do
    visit user_post_path(post.author, post)

    expect(page).to have_selector('.PostTitle', text: 'Title: Post Title')
    expect(page).to have_selector('.PostAuthor', text: 'Post by Tom')
    expect(page).to have_content('Comments: 3')
    expect(page).to have_content('Likes: 1')
    expect(page).to have_content('Post Title')
    expect(page).to have_selector('.CommentsAuthor', text: 'Tom')
    expect(page).to have_selector('.CommentsAuthor', text: 'hello Tom')
  end
end
