class JobsController < ApplicationController

  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      flash[:notice] = "Job listing was successfully created."
      redirect_to @job
    else
      flash.now[:alert] = "There was an error creating the job listing. Please try again."
      render :new
    end
  end


  def edit
    @job = Job.find(params[:id])
  end


  def update
    @job = Job.find(params[:id])
    @job.assign_attributes(job_params)

    if @job.save
      flash[:notice] = "Job listing was successfully updated."
      redirect_to @job
    else
      flash.now[:alert] = "There was an error updating the job listing. Please try again."
      render :edit
    end
  end

    def destroy
      @job = Job.find(params[:id])

      if @job.destroy
        flash[:notice] = "Job listing was successfully deleted"
        redirect_to jobs_path
      else
        flash.now[:alert] = "There was an error deleting the job listing. Please try again."
        render :show
      end
    end



  private

  def job_params
    params.require(:job).permit(:title, :location, :body)
  end


end