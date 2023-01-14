class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @new_project = Project.new
  end

  # POST /projects or /projects.json
  def create
    @projects = Project.all
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
        format.json { render :index, status: :created, location: @project }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
