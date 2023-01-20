class ProjectUpdatesController < ApplicationController
  before_action :set_project_udpate, only: %i[edit update destroy]

  # GET /project_updates/1/edit
  def edit; end

  # PATCH/PUT /project_updates/1 or /project_updates/1.json
  def update
    respond_to do |format|
      if @project_update.update(project_update_params)
        format.html { redirect_to project_path(@project_update.project), notice: 'Updated.' }
        format.json { render :index, status: :ok, location: @project_update }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: @project_update.errors.full_messages }
        format.json { render json: @project_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_updates/1 or /project_updates/1.json
  def destroy
    @project_update.destroy

    respond_to do |format|
      format.html { redirect_to project_updates_url, notice: 'Update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def project_update_params
    params.require(:project_update).permit(:stop_status, :reason, :note, :is_start, :manually_edited_time)
  end

  def set_project_udpate
    @project_update = ProjectUpdate.find(params[:id])
  end
end
