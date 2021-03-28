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

  # 検索字の要件
  def self.search_for(content, method)
    if method == 'perfect'
      Blog.where(title: content, body: content)
    elsif method == 'forward'
      Blog.where('title LIKE ? or body LIKE ?', content+'%',content+'%')
    elsif method == 'backward'
      Blog.where('title LIKE ? or body LIKE ?', '%'+content, '%'+content)
    else
      Blog.where('title LIKE ? or body LIKE ?', '%'+content+'%', '%'+content+'%')
    end
  end

  validates :title, presence: true, length: {maximum: 20, minimum: 5}
	validates :body, presence: true, length: {maximum: 300, minimum: 20}
  # メッセージでのエラー入力
  validates :category_id, presence: {message: 'category is required！！'}


end
