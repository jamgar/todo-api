class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id

  has_many :cards
end
