class Project < ApplicationRecord
  extend FriendlyId
  
  if Rails.env === 'production'
    searchkick word_middle: [:name]
  end
  belongs_to :user
  friendly_id :title, use: :slugged
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, :description, presence: true
  acts_as_votable
  has_many :suggestions, dependent: :destroy



  def search_data
      {
        title: title,
        description: description
        
      }
  end
end
