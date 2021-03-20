class Review < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :review_comments, dependent: :destroy
  attachment :image

end
