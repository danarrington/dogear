require 'rails_helper'

feature 'Signing out' do
  scenario 'Signing out via form' do
    user = create(:user)
    sign_in user

    visit '/books/'

    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully')
  end
end
