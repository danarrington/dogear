require "spec_helper"

feature "Listing Books" do
   scenario "List all books" do

      book = FactoryGirl.create(:book, name: "Redshirts")

      visit "/books"

      expect(page).to have_content("Redshirts")
   end

   scenario "View a book" do
      book = FactoryGirl.create(:book, name: "Redshirts",
                                pages: 314, current_page: 23)
      
      visit "/books"

      click_link "Redshirts"

      expect(page).to have_content("314")
      expect(page).to have_content("Redshirts")
      expect(page).to have_content("23")
   end
                                   
end
