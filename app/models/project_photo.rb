class ProjectPhoto < ApplicationRecord
  belongs_to :project

  validates :img_url, presence: true
end
