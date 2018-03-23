class UserPolicy < ApplicationPolicy
  include Devise

  attr_reader :user, :job

  def initialize(user, job)
    @user = user
    @job = job
  end

  def show?
    user.present?
  end


  def update?
    user.present? && (user)
  end


end
