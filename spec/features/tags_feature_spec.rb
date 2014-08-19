require 'rails_helper'

describe 'tagging posts' do
  before do
    visit 'users/sign_up'
    fill_in 'user[email]', with: "a@a.com"
    fill_in 'user[password]', with: "12345678"
    fill_in 'user[password_confirmation]', with: "12345678"
    click_button 'Sign up'
  end

  it 'displays tags as links under posts' do
    visit '/posts'
    click_link 'Add a post'
    fill_in 'Title', with: 'A brand new post'
    fill_in 'Tags', with: '#yolo, #swag'
    click_button 'Create Post'

    expect(page).to have_link '#yolo'
    expect(page).to have_link '#swag'
  end
end

describe 'filtering by tags' do

  end
