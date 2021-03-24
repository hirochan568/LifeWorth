class Review < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :review_comments, dependent: :destroy
  attachment :image
  has_many :review_favorites, dependent: :destroy

  def favorited_by?(user)
    review_favorites.where(user_id: user.id).exists?
  end

  # 検索字の要件
  def self.search_for(content, method)
    if method == 'perfect'
      Review.where(title: content)
    elsif method == 'forward'
      Review.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Review.where('title LIKE ?', '%'+content)
    else
      Review.where('title LIKE ?', '%'+content+'%')
    end
  end


  validates :title, presence: true
  validates :body, presence: true
  # メッセージでのエラー入力
  validates :category_id, presence: {message: 'category is required！！'}


end
