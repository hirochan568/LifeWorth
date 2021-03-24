class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ゲストユーザー作成

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guest"
      user.telephone = '09012345678'
    end
  end

  has_many :blogs, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :question_comments, dependent: :destroy
  has_many :blog_favorites, dependent: :destroy
  # has_many :blog_favorited_blogs, through: :blog_fovorites, source: :blog
  has_many :review_favorites, dependent: :destroy
  has_many :question_favorites, dependent: :destroy
  has_many :messages, dependent: :destroy

end
