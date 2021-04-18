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

  # 検索時の要件
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

  validates :title, presence: true, length: {maximum: 30, minimum: 5}
	validates :body, presence: true, length: {maximum: 2000, minimum: 20}
  # メッセージでのエラー入力
  validates :category_id, presence: {message: 'category is required！！'}

  def favorites_count
    blog_favorites.count
  end
  
  def comments_count
    blog_comments.count
  end
  
  def genre
    category.name
  end
  
  def truncate_count(num, column_type)
    if column_type == "title"
      title.truncate(num)
    else
      body.truncate(num)
    end
  end
end
