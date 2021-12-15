class Suggestion < ApplicationRecord
  # validate :ensure_suggestion_not_completed
  before_create :set_done
  belongs_to :user
  belongs_to :project
  acts_as_votable

  validates :content, presence: true

  private 

  def set_done
    self.done = false
  end

  # def ensure_suggestion_not_completed
  #    if self.done
  #     errors.add(:done, "This suggestion has already been completed")
  #    end
  # end
end
