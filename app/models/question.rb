class Question < ApplicationRecord
  
  belongs_to :user
  belongs_to :category
  has_many :question_comments, dependent: :destroy
  attachment :image
end
