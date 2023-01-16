class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @new_project = Project.new
  end

  # GET /projects/1 or /projects/1.json
  def show
    @project = Project.includes(:project_updates).find(params[:id])
  end

  # GET /projects/1/edit
  def edit
    @project = Project.includes(:project_updates).find(params[:id])
    @project_update = ProjectUpdate.new
    @status_change_type = params[:status_change_type]
  end

  # POST /projects or /projects.json
  def create
    @projects = Project.all
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
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
    puts project_update_params

    @project = Project.includes(:project_updates).find(params[:id])
    @project.name = project_params.fetch(:name)
    @project.project_updates.build(project_update_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: 'Project was successfully updated.' }
        format.json { render :index, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: @project.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project = Project.includes(:project_updates).find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, project_update: [:time_status, :reason, :note])
  end

  def project_update_params
    project_params.fetch(:project_update)
  end
end
