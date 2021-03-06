class User < ApplicationRecord
  has_secure_password

  has_many :boards
  has_many :todos, foreign_key: :created_by

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email
end
