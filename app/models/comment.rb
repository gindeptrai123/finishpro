class Comment < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  scope :select_comments, ->(id){where comment_id: id}
  scope :comment_type, ->(type){where comment_type: type}
  scope :comment_children, ->{where "parent_id != ?", "0"}
  scope :comment_id, ->(id){where parent_id: id}
  scope :newest, ->{order created_at: :desc}
end
