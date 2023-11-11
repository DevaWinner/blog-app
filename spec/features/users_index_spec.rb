require 'rails_helper'

RSpec.feature 'Post Index', type: :feature do
  before do
    User.create(name: 'Sponge Bob', photo: 'https://www.spongebobshop.com/cdn/shop/products/SB-Standees-Spong-1_900x.jpg?v=1603744567')
    User.create(name: 'Harry', photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QiBEo2EE4_Z7N9MqpmMVxj5Wk4aH_DNSX-FknA0UFLBJSlxyImfdXOS7F0Y_SJUNk9E&usqp=CAU')
    User.create(name: 'Patrick', photo: 'https://w0.peakpx.com/wallpaper/798/76/HD-wallpaper-patrick-bob-squarepants-star-thumbnail.jpg')
    User.create(name: 'Garry', photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png')
    User.create(name: 'Tom', photo: 'https://cdn.pixabay.com/photo/2020/05/11/15/38/tom-5158824_1280.png')
  end

  scenario "see user's profile picture, username, number of posts, interactions, etc." do
    visit users_path

    expect(page).to have_content('Sponge Bob')
    expect(page).to have_selector('img[src="https://www.spongebobshop.com/cdn/shop/products/SB-Standees-Spong-1_900x.jpg?v=1603744567"]')
  end

  scenario 'I can see the number of posts each user has written.' do
    user1 = User.find_by(name: 'Harry')
    _post1 = Post.create(author: user1, title: 'First Post')
    _post2 = Post.create(author: user1, title: 'Second Post')
    _post3 = Post.create(author: user1, title: 'Third Post')

    visit users_path

    expect(page).to have_content('Number of posts: 3')
  end

  scenario "When I click on a user, I am redirected to that user's show page." do
    visit users_path
    click_link 'Sponge Bob'

    expect(page).to have_selector(
      'img[src="https://www.spongebobshop.com/cdn/shop/products/SB-Standees-Spong-1_900x.jpg?v=1603744567"]', wait: 5
    )
    expected_path = user_path(User.find_by(name: 'Sponge Bob'))
    expect(current_path).to eq(expected_path)
  end
end
