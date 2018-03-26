class JobMailer < ApplicationMailer
  default from: "titchimoto@gmail.com"

  def new_candidate(user, job, candidate)
    headers["Message-ID"] = "<candidates/#{candidate.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<job/#{job.id}@your-app-name.example>"
    headers["References"] = "<job/#{job.id}@your-app-name.example>"

    @user = user
    @job = job
    @candidate = candidate

    mail(to: job.user.email, subject: "New candidate applied to #{job.title}")
  end
end
