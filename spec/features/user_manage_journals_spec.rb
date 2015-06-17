require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

feature "Users manage journals" do

  before do
    user = Fabricate(:user, name: "Jenny")
    Fabricate(:journal, title: "Sleep Tracking", user: user)
    Fabricate(:journal, title: "Movie Reviews", user: user)
    Fabricate(:journal, title: "Travel", user: user)
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Go!"
  end

  scenario "viewing list of journals" do
    visit root_path
    click_on "Journals"
    within("div.journals-container") do
      page.should have_css(".journal:nth-child(5) ul li:nth-child(2)", text: "Movie Reviews")
      page.should have_css(".journal:nth-child(6) ul li:nth-child(2)", text: "Sleep Tracking")
      page.should have_css(".journal:nth-child(7) ul li:nth-child(2)", text: "Travel")
    end
    page.should_not have_css("a", text: "Sort: Alphabetical")
    page.should have_content("Sort: Alphabetical")
    click_on "Sort: Date"
    within("div.journals-container") do
      page.should have_css(".journal:nth-child(5) ul li:nth-child(2)", text: "Sleep Tracking")
      page.should have_css(".journal:nth-child(6) ul li:nth-child(2)", text: "Movie Reviews")
      page.should have_css(".journal:nth-child(7) ul li:nth-child(2)", text: "Travel")
    end
    page.should_not have_css("a", text: "Sort: Date")
    page.should have_content("Sort: Date")
    click_on "Sort: Alphabetical"
    within("div.journals-container") do
      page.should have_css(".journal:nth-child(5) ul li:nth-child(2)", text: "Movie Reviews")
      page.should have_css(".journal:nth-child(6) ul li:nth-child(2)", text: "Sleep Tracking")
      page.should have_css(".journal:nth-child(7) ul li:nth-child(2)", text: "Travel")
    end
  end
end

