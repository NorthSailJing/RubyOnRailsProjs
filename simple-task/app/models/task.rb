class Task < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, completed: 1}

  scope :by_state, -> { order(status: :asc, id: :desc) }
  scope :completed_hours, -> { where(status: 1).sum(:duration) }

  validates_presence_of :title, :body, :client, :duration
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10000 }
end
