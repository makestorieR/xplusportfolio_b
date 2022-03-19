class Anticipation < ApplicationRecord
  include PublicActivity::Common
  if Rails.env === 'production' 
    searchkick word_middle: [:body]
  end

    before_create :set_slug
    after_commit :broadcast_anticipation
    before_save :penilize_user

    belongs_to :user
    belongs_to :anticipation_cover
    has_one :project
    
    has_many :comments, as: :commentable
    validates :due_date, :body, presence: true
    acts_as_followable
    acts_as_votable


    private 
    def set_slug 
        self.slug = Digest::MD5.hexdigest(self.body + Time.now.to_f.to_s.gsub(".", "") + SecureRandom.hex(5))
    end

    def penilize_user 
        if self.due_date_changed? 
           user.decrement!(:repu_coin, 50)
        end
        
    end

    def search_data
      {
        
        body: body
        
      }
    end
    
end
