require 'spec_helper'

feature 'Ppost' do
  describe 'new ppost' do
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit new_ppost_path
        expect(page).not_to have_content('New ppost')
        expect(page).to have_content('Email')
      end
    end

    context 'user is logged in' do
      background do
        user = create :user
        visit user_session_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_on 'Log in'
      end
      context 'with valid fields' do
        scenario 'creates the ppost' do
          visit new_ppost_path
          fill_in 'Title', with: 'New Post'
          fill_in 'Body', with: 'Very Good Post'
          click_on 'Create Ppost'
          expect(page).to have_content('New Post')
          expect(page).to have_content('Very Good Post')
        end
      end
    end
  end

  describe 'edit post' do
    let!(:owner) { create :user }
    let!(:ppost) { create :ppost, title: 'New Post', user_id: owner.id }

    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit edit_ppost_path(ppost)
        expect(page).not_to have_content('Edit ppost')
        expect(page).to have_content('Email')
      end
    end

    context 'post owner is logged in' do
      background do
        user = create :user
        visit user_session_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_on 'Log in'
      end

      context 'with valid fields' do
        scenario 'updates the post' do
          visit edit_ppost_path(ppost)
          fill_in 'Title', with: 'Edited Post'
          click_on 'Update Ppost'
          expect(page).to have_content('Edited Post')
          expect(page).not_to have_content('New Post')
        end
      end
    end
  end

  describe 'destroy post' do
    let!(:owner) { create :user }
    let!(:ppost) { create :ppost, title: 'New Post', user_id: owner.id }

    context 'post owner is logged in' do
      background do
        user = owner
        visit user_session_path

        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_on 'Log in'
      end

      scenario 'destroys the post' do
        visit pposts_path
        click_on 'Destroy'
        expect(page).not_to have_content('New Post')
      end
    end
  end

  describe 'show post' do
    let!(:ppost) { create :ppost, title: 'showing posts' }

    scenario 'shows the post' do
      visit pposts_path
      click_on 'Show'
      expect(page).to have_content('showing posts')
    end
  end

end