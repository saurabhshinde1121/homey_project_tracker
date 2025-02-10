# frozen_string_literal: true

class ProjectEventHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def index
    @histories = @project.project_event_histories.includes(:user).order(created_at: :desc)
      .page(params[:page]).per(10)
  end

  def create
    history = @project.project_event_histories.new(history_params.merge(user: current_user))
    if history.save
      redirect_to project_path(@project), notice: 'Comment added successfully.'
    else
      render :index
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def history_params
    params.require(:project_event_history).permit(:event_type, :content)
  end
end
