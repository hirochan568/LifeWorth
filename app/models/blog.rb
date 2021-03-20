class Blog < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :blog_comments, dependent: :destroy
  attachment :image

  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true

end
