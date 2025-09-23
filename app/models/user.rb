class User < ApplicationRecord
  has_secure_password

  has_many :books, foreign_key: :author_id, dependent: :destroy

  has_many :comments, dependent: :destroy

  enum role: { user: 0, author: 1 }

  validates :email, presence: true, uniqueness: true
end
