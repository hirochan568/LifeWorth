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
      Review.where(title: content, body: content)
    elsif method == 'forward'
      Review.where('title LIKE ? or body LIKE ?', content+'%',content+'%')
    elsif method == 'backward'
      Review.where('title LIKE ? or body LIKE ?', '%'+content, '%'+content)
    else
      Review.where('title LIKE ? or body LIKE ?', '%'+content+'%', '%'+content+'%')
    end
  end


  validates :title, presence: true, length: {maximum: 20, minimum: 5}
	validates :body, presence: true, length: {maximum: 300, minimum: 20}
  # メッセージでのエラー入力
  validates :category_id, presence: {message: 'category is required！！'}


end
