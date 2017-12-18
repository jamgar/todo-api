class Card < ApplicationRecord
  belongs_to :board
  has_many :notes, dependent: :destroy

  validates_presence_of :title
end
