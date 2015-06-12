require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users manage journals" do

  before do
    user = Fabricate(:user, name: "Jenny")
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Go!"
  end

  scenario "viewing journal list when empty" do
    visit root_path
    click_on "My Journals"
    page.should have_content("There aren't any journals yet")
    page.should_not have_content("Sort")
  end

  scenario "viewing list of journals" do
    Fabricate(:journal, title: "Sleep Tracking")
    Fabricate(:journal, title: "Movie Reviews")
    Fabricate(:journal, title: "Travel")
    visit root_path
    click_on "My Journals"
    current_path.should == "/journals" # We wouldn't normally test the exact path
    within("ul#journals") do
      page.should have_css("li:nth-child(1)", text: "Movie Reviews")
      page.should have_css("li:nth-child(2)", text: "Sleep Tracking")
      page.should have_css("li:nth-child(3)", text: "Travel")
    end
    page.should_not have_css("a", text: "Sort: Alphabetical")
    page.should have_content("Sort: Alphabetical")
    click_on "Sort: Date"
    within("ul#journals") do
      page.should have_css("li:nth-child(1)", text: "Sleep Tracking")
      page.should have_css("li:nth-child(2)", text: "Movie Reviews")
      page.should have_css("li:nth-child(3)", text: "Travel")
    end
    page.should_not have_css("a", text: "Sort: Date")
    page.should have_content("Sort: Date")
    click_on "Sort: Alphabetical"
    within("ul#journals") do
      page.should have_css("li:nth-child(1)", text: "Movie Reviews")
      page.should have_css("li:nth-child(2)", text: "Sleep Tracking")
      page.should have_css("li:nth-child(3)", text: "Travel")
    end
  end
end

