class Tour < ApplicationRecord
  mount_uploader :image, TourImageUploader

  belongs_to :user

  validates :title, presence: true, length: {minimum: Settings.length.title}
  validates :description, presence: true,
    length: {maximum: Settings.length.description}
  validates :content, presence: true, length: {maximum: Settings.length.content}
  validates :price, numericality: {greater_than: Settings.zero},
    allow_nil: true
  validates :date_in, :date_out, presence: true, allow_nil: true
  validate :date_in_before_date_out
  validates :image, presence: true
  UPDATE_ATTRS = [:title, :description, :content, :price, :date_in, :date_out,
    :image].freeze

  scope :search, ->(title){where "title LIKE ?", "%#{title}%"}

  private

  def date_in_before_date_out
    return unless date_in && date_out

    errors.add(:date_in, I18n.t("err_add.date")) if date_in > date_out
  end
end
