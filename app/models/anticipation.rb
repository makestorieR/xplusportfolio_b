class Anticipation < ApplicationRecord
    before_create :set_slug
    before_save :penilize_user

    belongs_to :user
    belongs_to :anticipation_cover
    
    has_many :comments, as: :commentable
    validates :due_date, :body, presence: true
    acts_as_followable
    acts_as_votable


    private 
    def set_slug 
        self.slug = Digest::MD5.hexdigest(self.body + Time.current.to_s + ENV['DIGEST_SECRET'])
    end

    def penilize_user 
        if self.due_date_changed? 
           user.decrement!(:repu_coin, 50)
        end
        
    end
    
end
