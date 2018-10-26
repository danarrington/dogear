# frozen_string_literal: true

require 'spec_helper'

feature 'Signing in' do
  scenario 'Signing in via form' do
    user = create(:user)

    visit '/'

    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully')
  end
end
