class Category < ApplicationRecord
  
  has_many :blogs
  has_many :reviews
  has_many :questions
    
  
end
