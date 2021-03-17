class Blog < ApplicationRecord
  
  belongs_to :user
  belongs_to :category
  has_many :blog_comments, dependent: :destroy
  
end
