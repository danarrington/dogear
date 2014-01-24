require 'spec_helper'

feature 'Listing Books' do
   scenario 'List all books' do

      FactoryGirl.create(:book, title: 'Redshirts')

      visit '/books/list'

      expect(page).to have_content('Redshirts')
   end

   scenario 'View a book' do
      FactoryGirl.create(:book, title: 'Redshirts',
                                pages: 314, current_page: 23)
      
      visit '/books/list'

      click_link 'Redshirts'

      expect(page).to have_content('314')
      expect(page).to have_content('Redshirts')
      expect(page).to have_content('23')
   end

   scenario 'Visit Root Page' do
      FactoryGirl.create(:book, title: 'Redshirts', pages: 314, current_page: 23, updated_at: Date.today)
      FactoryGirl.create(:book, title: 'Old Mans War', pages: 310, current_page: 0, updated_at: Date.yesterday)

      visit '/'

      expect(page).to have_content('314')
      expect(page).to have_content('Redshirts')
      expect(page).to have_content('23')
   end

                                   
end
