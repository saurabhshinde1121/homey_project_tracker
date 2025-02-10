# frozen_string_literal: true

module ProjectsHelper
  def status_badge_class(status)
    case status.to_s.downcase.gsub(' ', '_')
    when 'completed'
      'bg-success'
    when 'in_progress'
      'bg-primary'
    when 'on_hold'
      'bg-warning'
    when 'cancelled'
      'bg-danger'
    when 'todo'
      'bg-info'
    else
      'bg-secondary'
    end
  end

  def format_status(status)
    status.to_s.humanize
  end
end
