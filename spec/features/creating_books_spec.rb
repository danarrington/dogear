require 'spec_helper'

feature "Creating Books" do
   scenario "Create a Book" do

      visit "/books"

      click_link("Add new book")

      fill_in "Name", with: "Redshirts"
      fill_in "Pages", with: 268
      click_button("Create")

      expect(page).to have_content("Book has been added")
      expect(page).to have_content("Redshirts")
   end
end
