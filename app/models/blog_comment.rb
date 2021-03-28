class BlogComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :blog
  
  validates :comment, presence: true, length: {maximum: 150, minimum: 5}
  
end
