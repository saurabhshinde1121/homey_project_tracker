# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :project_histories, dependent: :destroy
  belongs_to :owner, class_name: 'User', optional: false

  enum status: {
    todo: 'Todo',
    in_progress: 'In Progress',
    completed: 'Completed',
    on_hold: 'On Hold',
    cancelled: 'Cancelled'
  }, _default: 'todo'
end
