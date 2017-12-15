class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_by, :updated_at

  has_many :items
end
