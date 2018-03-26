module UsersHelper

  def user_is_employer
    current_user && (current_user.employer? || current_user.admin? )
  end

  def user_is_job_owner
    current_user && (@job.user. == current_user || current_user.admin? )
  end

  def user_is_standard
    current_user && current_user.standard?
  end

  def already_candidate
    current_user && @job.candidate?
  end

end
