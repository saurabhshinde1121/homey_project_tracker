# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get projects_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      get project_path(project)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    let(:valid_params) { { project: attributes_for(:project) } }

    it 'creates a new project' do
      expect do
        post projects_path, params: valid_params
      end.to change(Project, :count).by(1)
      expect(response).to redirect_to(project_path(Project.last))
    end
  end

  describe 'PATCH /update' do
    context 'name' do
      let(:update_params) { { project: { name: 'Updated Name' } } }

      it 'updates the project name' do
        patch project_path(project), params: update_params
        expect(response).to redirect_to(project_path(project))
        expect(project.reload.name).to eq('Updated Name')
      end
    end

    context 'status' do
      let(:update_params) { { project: { status: 'completed' } } }

      it 'updates the project name' do
        patch project_path(project), params: update_params
        expect(response).to redirect_to(project_path(project))
        expect(project.reload.status).to eq('completed')
        expect(project.project_event_histories.last.event_type).to eq('status_change')
        expect(project.project_event_histories.last.content)
          .to eq('Changed status from Todo to Completed')
      end
    end
  end

  describe 'GET /history' do
    it 'returns a successful response' do
      get history_project_path(project)
      expect(response).to have_http_status(:ok)
    end
  end
end
