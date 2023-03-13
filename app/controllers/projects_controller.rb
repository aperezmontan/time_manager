# frozen_string_literal: true

# The Controller for manipulating Projects
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authorize_user, except: %i[show edit index]

  def index
    @projects = policy_scope(Project).includes(:project_updates).all
    @new_project = Project.new
  end

  # GET /projects/1 or /projects/1.json
  def show; end

  # GET /projects/1/edit
  def edit
    @project_update = ProjectUpdate.new
    @status_change_type = params[:status_change_type]
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if project_save
        format.html { redirect_to projects_url, notice: 'Project was successfully created.' }
        format.json { render :index, status: :created, location: @project }
      else
        format.html { render :index, status: :unprocessable_entity, alert: @project.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
        format.json { render :index, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: @project.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def authorize_user
    project = @project || Project
    authorize(project)
  end

  def project_params
    params.require(:project).permit(:name,
                                    project_updates_attributes: %i[stop_status reason note is_start
                                                                   manually_edited_time])
  end

  # Wraps the save and the access control in a transaction so that
  # either both are saved or neither
  def project_save
    ActiveRecord::Base.transaction do
      @project.save!
      @project_access_control = ProjectAccessControl.new(project: @project, user: current_user,
                                                         level: ProjectAccessControl.levels.fetch('owner'))
      @project_access_control.save!
    end
  end

  def set_project
    @project = policy_scope(Project).includes(:project_updates).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_url, alert: 'Project not found'
  end
end
