# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should have_many(:project_event_histories).dependent(:destroy) }
    it { should belong_to(:owner).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(%w[todo in_progress completed on_hold cancelled]) }
  end

  describe '#update_status' do
    let(:user) { create(:user) }
    let(:project) { create(:project, status: 'todo', owner: user) }

    it 'updates the status and creates a project event history' do
      expect do
        project.update_status('in_progress', user)
      end.to change { project.project_event_histories.count }.by(1)

      expect(project.status).to eq('in_progress')
      expect(project.project_event_histories.last.content).to eq('Changed status from Todo to In progress')
    end

    it 'does not create an event history if update fails' do
      allow(project).to receive(:update).and_return(false)
      expect do
        project.update_status('completed', user)
      end.not_to(change { project.project_event_histories.count })
    end
  end
end
