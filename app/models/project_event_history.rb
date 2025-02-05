# frozen_string_literal: true

class ProjectEventHistory < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum event_type: { comment: 0, status_change: 1 }
end
