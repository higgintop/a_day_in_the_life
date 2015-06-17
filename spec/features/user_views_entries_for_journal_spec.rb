require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users views entries for a journal" do


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

  scenario "happy path viewing entries" do
    click_on "Journals"
    click_on "View"
    page.should have_content("Trip to Spain")
  end
end



