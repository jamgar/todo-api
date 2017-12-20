require 'rails_helper'

RSpec.describe Note, type: :model do
  it { should belong_to :card }
  it { validate_presence_of :content}
end
