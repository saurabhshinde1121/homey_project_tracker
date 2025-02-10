# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectEventHistoriesController, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user) }

  before do
    sign_in user
  end

  describe 'POST /create' do
    let(:valid_params) { { project_event_history: { event_type: 'comment', content: 'This is a test comment' } } }
    let(:invalid_params) { { project_event_history: { event_type: 'invalid', content: '' } } }

    it 'creates a new project event history' do
      expect do
        post project_project_event_histories_path(project), params: valid_params
      end.to change(ProjectEventHistory, :count).by(1)
      expect(response).to redirect_to(project_path(project))
    end

    it 'raises an error when event_type is nil' do
      expect do
        post project_project_event_histories_path(project), params: invalid_params
      end.to raise_error(ArgumentError, /is not a valid event_type/)
    end
  end
end
