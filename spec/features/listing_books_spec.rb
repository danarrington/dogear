require 'spec_helper'

feature 'Listing Books' do
  background :each do
    @user = create(:user)

    sign_in @user
  end
  scenario 'List all books' do

    FactoryGirl.create(:book, title: 'Redshirts', user:@user)
    FactoryGirl.create(:book, title: 'Just a Geek', user:@user, finished:true)

    visit '/books'

    within('#open-books') do
      expect(page).to have_content('Redshirts')
    end
    within('#finished-books') do
      expect(page).to have_content('Just a Geek')
    end
  end

  scenario 'View a book' do
    FactoryGirl.create(:book, title: 'Redshirts',
                       pages: 314, current_page: 23, user:@user)

    visit '/books'

    click_link 'Redshirts'

    expect(page).to have_content('314')
    expect(page).to have_content('Redshirts')
    expect(page).to have_content('23')
  end

  scenario 'View a kindle book' do
    FactoryGirl.create(:book, title: 'Redshirts',
                       pages: 300, current_page: 25, user:@user, kindle:true)

    visit '/books'
    click_link 'Redshirts'

    expect(page).to have_content('75')
    expect(page).to have_content('25%')
  end

  scenario 'Visit Root Page' do
    pending
    FactoryGirl.create(:book, title: 'Redshirts', pages: 314, current_page: 23, updated_at: Date.today)
    FactoryGirl.create(:book, title: 'Old Mans War', pages: 310, current_page: 0, updated_at: Date.yesterday)

    visit '/'

    expect(page).to have_content('314')
    expect(page).to have_content('Redshirts')
    expect(page).to have_content('23')
  end


end
