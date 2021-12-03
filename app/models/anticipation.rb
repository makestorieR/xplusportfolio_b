class Anticipation < ApplicationRecord
    belongs_to :user
    validates :due_date, :body, presence: true
end
