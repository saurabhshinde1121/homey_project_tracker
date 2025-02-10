# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show update]

  def index
    @projects = Project.page(params[:page]).per(10)
  end

  def show
    @project = Project.find(params[:id])
    @histories = @project.project_event_histories.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @project = Project.new
    @project.owner = current_user # Set current user as default owner
  end

  def create
    @project = Project.new(project_params)
    @project.owner = current_user # assuming the user creating the project is the owner
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    if update_params[:status].present?
      update_status
    elsif @project.update(project_params)
      redirect_to @project, notice: 'Project updated successfully.'
    else
      render :edit
    end
  rescue ActiveRecord::RecordInvalid => e
    respond_to do |format|
      format.html { render :show }
      format.json { render json: { success: false, errors: e.message }, status: :unprocessable_entity }
    end
  end

  def history
    @project = Project.find(params[:id])
    @histories = @project.project_event_histories.order(created_at: :desc).page(params[:page]).per(10)
    render partial: 'history', locals: { project: @project, histories: @histories }
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status, :owner_id)
  end

  def update_params
    params.require(:project).permit(:status)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def update_status
    if @project.update_status(update_params[:status], current_user)
      respond_to do |format|
        format.html { redirect_to @project, notice: 'Project updated successfully.' }
        format.json { render json: { status: @project.status, success: true }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :show }
        format.json { render json: { success: false, errors: @project.errors }, status: :unprocessable_entity }
      end
    end
  end
end
