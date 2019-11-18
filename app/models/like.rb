class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  scope :like_review, ->(id){where review_id: id}
end
