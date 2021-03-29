class Message < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, length: {maximum: 30, minimum: 5}
  validates :body, presence: true, length: {maximum: 150, minimum: 5}
end
