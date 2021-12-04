class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to  :parent, class_name: "Comment", optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  acts_as_votable

end
