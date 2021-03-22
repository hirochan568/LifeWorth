class Review < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :review_comments, dependent: :destroy
  attachment :image
  has_many :review_favorites, dependent: :destroy

  def favorited_by?(user)
    review_favorites.where(user_id: user.id).exists?
  end


  validates :title, presence: true
  validates :body, presence: true
  # メッセージでのエラー入力
  validates :category_id, presence: {message: 'category is required！！'}


end
