require 'rails_helper'

RSpec.describe Journal, type: :model do
  describe "validations" do
    after(:each) do
      described_class.destroy_all
    end
    it "should be invalid without a title" do
      Fabricate.build(:journal, title: nil).should_not be_valid
    end
    it "should be invalid if title is all whitespace" do
      Fabricate.build(:journal, title: "         ").should_not be_valid
    end
    it "should have unique titles" do
      some_title = Faker::Name.name
      Fabricate(:journal, title: some_title)
      Fabricate.build(:journal, title: some_title).should_not be_valid
    end
  end
end