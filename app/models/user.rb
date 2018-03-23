class User < ApplicationRecord

  enum role: [:standard, :employer, :admin]

  has_many :jobs, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 1, maximum: 50 }

  after_initialize :set_role
  before_save { self.email = email.downcase if email.present? }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def favorite_for(job)
    favorites.where(job_id: job.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end


  private

  def set_role
    self.role ||= 0
  end


end
