require 'rails_helper'

RSpec.describe Entry, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :post }
  it { should validate_presence_of :user }
  it { should validate_presence_of :journal }
end
