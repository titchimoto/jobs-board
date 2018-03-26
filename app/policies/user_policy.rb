class UserPolicy < ApplicationPolicy
  include Devise

  attr_reader :user, :users

  def initialize(user, users)
    @user = user
    @users = users
  end

  def show?
    user.present? && (user == users || user.employer?)
  end


  def update?
    user == users
  end


end
