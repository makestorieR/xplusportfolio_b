class Anticipation < ApplicationRecord
    belongs_to :user
    has_many :comments, as: :commentable
    validates :due_date, :body, presence: true
    acts_as_likeable
end
