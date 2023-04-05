# frozen_string_literal: true

# The Controller for manipulating Projects
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_times, only: %i[show]
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
        # TODO: FIXME - THIS IS TERRIBLE
        @project.project_updates.last.update(status: 'finished') if params[:finished] == 'true'
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
                                    project_updates_attributes: %i[status reason note is_start manually_edited_date
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

  # def datetime_params
  #   # "manually_edited_datetime(1i)"=>"2023", "manually_edited_datetime(2i)"=>"4", "manually_edited_datetime(3i)"=>"3", "manually_edited_datetime(4i)"=>"21", "manually_edited_datetime(5i)"=>"34"
  #   manually_edited_datetime_date_params = project_params["manually_edited_datetime(date)"]
  #   manually_edited_datetime_time_params = project_params["manually_edited_datetime(time)"]
  #   manually_edited_datetime_params
  # end

  def set_project
    @project = policy_scope(Project).includes(:project_updates).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_url, alert: 'Project not found'
  end

  def set_times
    return unless @project.project_updates.any?

    @days_since_start = @project.project_updates.map(&:manually_edited_datetime).map(&:to_date).uniq

    time_intervals = []

    @project.project_updates.order(manually_edited_datetime: :asc).each_slice(2) do |start, stop|
      time_intervals << if stop.nil?
                          (Time.current - start.manually_edited_datetime)
                        else
                          (stop.manually_edited_datetime - start.manually_edited_datetime)
                        end
    end

    @hours_worked = time_intervals.reduce(0) do |total_time, time_interval|
      total_time + time_interval
    end / 3600
  end
end
