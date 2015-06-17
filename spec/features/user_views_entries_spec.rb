require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users views journal entries" do


  before do
    user = Fabricate(:user, name: "Jenny")
    journal = Fabricate(:journal, title: "Travelling", user: user)
    Fabricate(:entry, title: "Trip to Spain", post: "Had a fun time!",journal: journal)
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Go!"
  end

  scenario "viewing archive of entries" do
    click_on "Journals"
    click_on "View"
    page.should have_content("Trip to Spain")
    click_on "Archive"
    page.should have_content("Trip to Spain")
  end

  scenario "viewing calendar of entries" do
    click_on "Journals"
    click_on "View"
    page.should have_content("Trip to Spain")
    click_on "Calendar"
    page.should have_content("Trip to Spain")
  end
end




