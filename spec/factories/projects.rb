# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Company.catch_phrase }
    status { 'todo' }
    association :owner, factory: :user
  end
end
