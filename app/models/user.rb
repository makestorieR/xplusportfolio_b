# frozen_string_literal: true

class User < ActiveRecord::Base
  extend FriendlyId
  include DeviseTokenAuth::Concerns::User

  after_commit :create_background_cover_photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :omniauthable
  if Rails.env === 'production'
    searchkick word_middle: [:name]
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  friendly_id :name, use: :slugged

  validates :name, presence: true
  has_many :projects, dependent: :destroy
  has_many :anticipations, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :webpush_subscriptions, class_name: "WebPushNotification", dependent: :destroy
  has_one :background_cover_photo, dependent: :destroy
  acts_as_followable
  acts_as_follower
  acts_as_voter

  private 
  
  def search_data
    {
      name: name,
      
    }
  end


  def create_background_cover_photo


    BackgroundCoverPhoto.create user: self
  end

  
end
