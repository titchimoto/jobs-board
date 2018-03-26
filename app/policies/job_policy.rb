class JobPolicy < ApplicationPolicy

  attr_reader :user, :job

  def initialize(user, job)
    @user = user
    @job = job
  end

  def show?
    user.present?
  end

  def create?
    user.present? && user.employer?
  end

  def update?
    user.present? && (job.user == user)
  end

  def destroy?
    @job.user == user
  end

end
