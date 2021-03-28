class Message < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, length: {maximum: 20, minimum: 5}
  validates :body, presence: true, length: {maximum: 50, minimum: 10}
end
