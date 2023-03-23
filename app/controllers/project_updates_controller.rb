# frozen_string_literal: true

# The Controller for manipulating ProjectUpdates
class ProjectUpdatesController < ApplicationController
  before_action :set_project_udpate, only: %i[edit update destroy]

  # GET /project_updates/1/edit
  def edit; end

  # PATCH/PUT /project_updates/1 or /project_updates/1.json
  def update
    respond_to do |format|
      @project_update.assign_attributes(project_update_params)
      @project_update.assign_attributes({ 'status' => 'finished' }) if params[:finished] == 'true'

      if @project_update.save
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
      format.html { redirect_to project_url(@project_update.project), notice: 'Update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def project_update_params
    params.require(:project_update).permit(:status, :reason, :note, :manually_edited_time)
  end

  def set_project_udpate
    @project_update ||= ProjectUpdate.includes(:project).find(params[:id])
  end
end
