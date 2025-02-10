# frozen_string_literal: true

FactoryBot.define do
  factory :project_event_history do
    content { Faker::Lorem.sentence }
    event_type { ProjectEventHistory.event_types.keys.sample }
    association :project
    association :user
  end
end
