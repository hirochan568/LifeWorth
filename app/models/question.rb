class Question < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :question_comments, dependent: :destroy
  attachment :image
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  
  validates :title, presence: true
  validates :body, presence: true
  validates :category_id, presence: true


end
