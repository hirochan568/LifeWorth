class Blog < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :blog_comments, dependent: :destroy
  attachment :image
  has_many :blog_favorites, dependent: :destroy
  # has_many :blog_favorited_users, through: :blog_favorites, source: :user

  def favorited_by?(user)
    blog_favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :body, presence: true
  # メッセージでのエラー入力
  validates :category_id, presence: {message: 'category is required！！'}


end
