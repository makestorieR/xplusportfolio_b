class Anticipation < ApplicationRecord
    belongs_to :user
    belongs_to :anticipation_cover
    
    has_many :comments, as: :commentable
    validates :due_date, :body, presence: true
    acts_as_followable
    
end
