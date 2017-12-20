class Note < ApplicationRecord
  belongs_to :card

  validates_presence_of :content
end
