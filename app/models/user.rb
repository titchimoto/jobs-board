class User < ApplicationRecord

  has_attached_file :resume, styles: { }, default_url: ""
  validates_attachment :resume, :content_type => {:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

  enum role: [:standard, :employer, :admin]

  has_many :jobs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :candidates, dependent: :destroy

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

  def candidate_for(job)
    candidates.where(job_id: job.id).first
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
