class ProjectUpdatesController < ApplicationController
  # GET /project_updates/1/edit
  def edit
    @project_update = ProjectUpdate.find(params[:id])
  end

  # PATCH/PUT /project_updates/1 or /project_updates/1.json
  def update
    @project_update = ProjectUpdate.find(params[:id])
    old_attrs = @project_update.attributes

    respond_to do |format|
      if @project_update.update(old_attrs.merge!(project_update_params))
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
    @project_update = ProjectUpdate.find(params[:id])
    @project_update.destroy

    respond_to do |format|
      format.html { redirect_to project_updates_url, notice: 'Update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def project_update_params
    params.require(:project_update).permit(:time_status, :reason, :note, :manual_update_time)
  end
end
