# frozen_string_literal: true

class User < ActiveRecord::Base
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User
  friendly_id :name, use: :slugged

  validates :name, presence: true
  has_many :projects, dependent: :destroy
  has_many :anticipations, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  acts_as_followable
  acts_as_follower
  acts_as_voter
  
end
