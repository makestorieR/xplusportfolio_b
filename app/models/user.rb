# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  has_many :projects, dependent: :destroy
  has_many :anticipations, dependent: :destroy
  has_many :notifications, as: :recipient
  acts_as_liker
  acts_as_followable
  acts_as_follower
  
end
