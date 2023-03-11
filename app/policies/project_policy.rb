class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def update?
    project.owner_ids.include?(user.id)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def create?
    true
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:project_access_controls).where("project_access_controls.user_id = #{user.id}")
      end
    end

    private

    attr_reader :user, :scope
  end
end
