class Suggestion < ApplicationRecord
  belongs_to :user
  belongs_to :project
  acts_as_votable

  validates :content, presence: true
end
