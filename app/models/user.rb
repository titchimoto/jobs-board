class User < ApplicationRecord

  enum role: [:standard, :employer, :admin]

  has_many :jobs, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 1, maximum: 50 }

  before_save { self.email = email.downcase if email.present? }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  private

  def set_role
    self.role ||= 0
  end


end
