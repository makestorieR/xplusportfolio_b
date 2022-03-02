class Project < ApplicationRecord
  extend FriendlyId
  include PublicActivity::Common
  
  # if Rails.env === 'production' || Rails.env === 'development'
  #   searchkick word_middle: [:title, :description]
  # end
  
  belongs_to :user
  belongs_to :anticipation,  optional: true
  friendly_id :title, use: :slugged
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, :description, presence: true
  acts_as_votable
  has_many :suggestions, dependent: :destroy
  has_many :tools, dependent: :destroy
  has_many :project_photos, dependent: :destroy



  def search_data
      {
        title: title,
        description: description
        
      }
  end
end
