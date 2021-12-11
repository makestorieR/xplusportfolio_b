class WebPushNotification < ApplicationRecord
  belongs_to :user

  validates :p256dh_key, :auth_key, presence: true
end
