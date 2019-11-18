class Category < ApplicationRecord
  has_many :reviews

  validates :name, presence: true

  scope :newest, ->{order created_at: :desc}
end
