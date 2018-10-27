# frozen_string_literal: true

require 'spec_helper'

feature 'Creating Books' do
  scenario 'Create a Book' do
    user = create(:user)
    sign_in user

    visit '/books'

    click_link('Add new book')

    fill_in 'Title', with: 'Redshirts'
    fill_in 'Pages', with: 268
    click_button('Create')

    expect(page).to have_content('Book has been added')
    expect(page).to have_content('Redshirts')
  end
end
