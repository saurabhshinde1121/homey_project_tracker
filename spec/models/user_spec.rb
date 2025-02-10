# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }

    # For Devise models, we need to create a user first
    subject { create(:user) }
    it { should validate_uniqueness_of(:email).case_insensitive.ignoring_case_sensitivity }
  end
end
