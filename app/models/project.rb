class Project < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  friendly_id :title, use: :slugged
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, :description, presence: true
  acts_as_votable
  
end
