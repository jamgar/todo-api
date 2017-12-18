require 'rails_helper'

RSpec.describe Card, type: :model do
  it { should belong_to(:board) }
  it { should have_many(:notes).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
