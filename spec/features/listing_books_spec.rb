require 'spec_helper'

feature 'Listing Books' do
   before :each do
     @user = create(:user)

     visit '/'

     click_link 'Sign in'
     fill_in 'Email', with: @user.email
     fill_in 'Password', with: @user.password
     click_button 'Sign in'
   end
   scenario 'List all books' do

      FactoryGirl.create(:book, title: 'Redshirts', user:@user)

      visit '/books'

      expect(page).to have_content('Redshirts')
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
