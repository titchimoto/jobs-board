class ChargePolicy < ApplicationPolicy

  attr_reader :user, :charge

  def initialize(user, charge)
    @user = user
    @charge = charge
  end

  def new?
    user.standard?
  end

  def create?
    user.standard?
  end

end
