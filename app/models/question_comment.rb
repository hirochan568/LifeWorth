class QuestionComment < ApplicationRecord

  belongs_to :user
  belongs_to :question

   validates :comment, presence: true, length: {maximum: 150, minimum: 5}

end
