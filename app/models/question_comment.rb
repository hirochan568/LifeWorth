class QuestionComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :question
  
end
