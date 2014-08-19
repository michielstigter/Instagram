require 'rails_helper'

describe 'posts' do
  context 'when logged in' do
    before do
      visit 'users/sign_up'
      fill_in 'user[email]', with: "a@a.com"
      fill_in 'user[password]', with: "12345678"
      fill_in 'user[password_confirmation]', with: "12345678"
      click_button 'Sign up'
    end

    context 'no posts added yet' do
      it 'should display a link to add a post' do
        visit '/posts'
        expect(page).to have_content 'No posts yet'
        expect(page).to have_link 'Add a post'
      end
    end

    context 'with posts' do
      before do
        Post.create(title: 'Hello World!')
      end

      it 'displays a list of all posts' do
        visit '/posts'
        expect(page).to have_content 'Hello World!'
      end
    end

    context 'adding posts' do
      it 'allows a user to post a post' do
        visit '/posts'
        click_link 'Add a post'
        expect(current_path).to eq new_post_path
        fill_in 'Title', with: 'A brand new post'
        click_button 'Create Post'
        expect(current_path).to eq '/posts'
        expect(page).to have_content 'A brand new post'
      end

      it 'can attach an image to a post' do
        visit '/posts'
        click_link 'Add a post'
        fill_in 'Title', with: 'A brand new post'
        attach_file 'Picture', Rails.root.join('spec/images/asap.jpg')
        click_button 'Create Post'
        expect(page).to have_css 'a.uploaded-pic'
      end
    end
  end

  context 'when not logged in' do
    it 'prevents a user to upload a picture' do
      visit '/posts'
      expect(page).to_not have_content 'Add a post'
    end

    before do
      Post.create(title: 'Hello World!')
    end

    it 'displays a list of all posts' do
      visit '/posts'
      expect(page).to have_content 'Hello World!'
    end
  end
end
