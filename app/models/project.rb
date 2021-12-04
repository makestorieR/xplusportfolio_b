class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  validates :title, :description, presence: true
  acts_as_votable
end
