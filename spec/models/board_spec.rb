require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should have_many(:cards).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
