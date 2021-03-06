# frozen_string_literal: true

require 'rails_helper'

feature 'Reading Books' do
  background :each do
    @user = create(:user)
    sign_in @user

    FactoryGirl.create(:book, title: 'Redshirts', current_page: 2, user: @user,
                              updated_at: 1.day.ago)
  end
  scenario 'Read a Book' do
    visit '/books/'
    click_link 'Redshirts'

    expect(page).to have_content('2')

    fill_in 'book_current_page', with: '25'

    click_button 'Submit'

    expect(page).to have_content('25')
  end

  scenario 'Finish a Book' do
    visit '/'
    expect(page).to_not have_content('Finish')
    fill_in 'book_current_page', with: 100
    click_button 'Submit'

    click_button 'Finish'

    expect(page).to have_content('finished')
    expect(page).to_not have_field('book_current_page')
  end

  scenario 'Re-open a book' do
    visit '/'
    fill_in 'book_current_page', with: 53
    click_button 'Submit'

    click_button 'Finish' # whoops, didn't mean to finish it

    click_button 'Re-Open'

    expect(page).to have_content('days of reading')
    expect(page).to have_content('Submit')
  end
end
