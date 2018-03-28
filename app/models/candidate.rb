class Candidate < ApplicationRecord
  belongs_to :job
  belongs_to :user

  validates :body, length: { minimum: 5, maximum: 10000 }, presence: true
  validates :user, presence: true

  after_create :send_candidate_emails

  private

  def send_candidate_emails
      JobMailer.new_candidate(job.user.email, job, job.candidates.last).deliver_now
  end
end
