require 'spec_helper'

feature 'Reading Books' do
  background :each do
    @user = create(:user)
    sign_in @user

    FactoryGirl.create(:book, title: 'Redshirts', current_page: 2, user:@user, updated_at: 1.day.ago)
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

    #click_link 'DogEar'
    #expect()
  end
end
