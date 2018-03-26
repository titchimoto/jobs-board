class CandidatesController < ApplicationController

  before_action :authenticate_user!

  def create
    @job = Job.find(params[:job_id])
    candidate = @job.candidates.new(candidate_params)
    candidate.user = current_user

    if candidate.save
      flash[:notice] = "Congratulations! You successfully applied for the job."
      redirect_to @job
    else
      flash[:alert] = "Error applying for job. Please try again."
      redirect_to @job
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    candidate = @job.candidates.find(params[:id])

    if candidate.destroy
      flash[:notice] = "Application successfully removed."
      redirect_to @job
    else
      flash[:alert] = "Error removing application. Please try again."
      redirect_to @job
    end
  end


    private

    def candidate_params
      params.require(:candidate).permit(:body)
    end



end
