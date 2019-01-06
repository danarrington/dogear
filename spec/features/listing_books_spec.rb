# frozen_string_literal: true

require 'rails_helper'

feature 'Listing Books' do
  background :each do
    @user = create(:user)

    sign_in @user
  end
  scenario 'List all books' do
    create(:book, title: 'Redshirts', user: @user)
    book2 = create(:book, title: 'Just a Geek', user: @user, finished: true,
                          updated_at: Date.new(2018))
    book3 = create(:book, title: 'Cryoburn', user: @user, finished: true,
                          updated_at: Date.new(2018))
    create(:bookmark, book: book2)
    create(:bookmark, book: book3)

    visit '/books'

    within('#open-books') do
      expect(page).to have_content('Redshirts')
    end
    within('#finished-books') do
      expect(page).to have_content('2018 (2)')
      expect(page).to have_content('Just a Geek')
    end
  end

  scenario 'View a book' do
    create(:book, title: 'Redshirts',
                  pages: 314, current_page: 23, user: @user)

    visit '/books'

    click_link 'Redshirts'

    expect(page).to have_content('314')
    expect(page).to have_content('Redshirts')
    expect(page).to have_content('23')
  end

  scenario 'View a kindle book' do
    create(:book, title: 'Redshirts',
                  pages: 300, current_page: 25, user: @user, kindle: true)

    visit '/books'
    click_link 'Redshirts'

    expect(page).to have_content('75')
    expect(page).to have_content('25%')
  end

  scenario 'Visit Root Page' do
    create(:book, title: 'Redshirts', pages: 314, current_page: 23,
                  updated_at: Date.today, user: @user)
    create(:book, title: 'Old Mans War', pages: 310, current_page: 0,
                  updated_at: Date.yesterday, user: @user)

    visit '/'

    # Should redirect to most recently updated book
    expect(page).to have_content('Redshirts')
    expect(page).to have_content('23')
  end
end
