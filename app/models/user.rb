class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :blogs, dependent: :destroy
        has_many :reviews, dependent: :destroy
        has_many :questions, dependent: :destroy
        has_many :blog_comments, dependent: :destroy
        has_many :review_comments, dependent: :destroy
        has_many :question_comments, dependent: :destroy
        has_many :blog_favorites, dependent: :destroy
        has_many :review_favorites, dependent: :destroy
        has_many :question_favorites, dependent: :destroy
end
