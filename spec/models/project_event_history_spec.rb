# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectEventHistory, type: :model do
  describe 'associations' do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe 'enums' do
    it { should define_enum_for(:event_type).with_values(comment: 0, status_change: 1) }
  end
end
