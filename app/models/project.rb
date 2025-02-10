# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :project_event_histories, dependent: :destroy
  belongs_to :owner, class_name: 'User', optional: false

  enum status: { 'todo' => 0, 'in_progress' => 1, 'completed' => 2, 'on_hold' => 3, 'cancelled' => 4 }

  validates :name, presence: true
  validates :status, presence: true

  def update_status(new_status, user)
    return unless update(status: new_status)

    project_event_histories.create!(
      user: user,
      event_type: :status_change,
      content: "Changed status from #{status_before_last_save.humanize} to #{status.humanize}"
    )
  end
end
