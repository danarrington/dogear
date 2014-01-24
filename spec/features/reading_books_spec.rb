require 'spec_helper'

feature 'Reading Books' do
   scenario "Read a Book" do
      FactoryGirl.create(:book, title: "Redshirts", current_page: 2)

      visit "/books/list"
      click_link "Redshirts"

      click_link "Read"

      expect(page).to have_content("2")

      fill_in "book_current_page", with: "25"

      click_button "Update Book"

      expect(page).to have_content("25")
   end
end
