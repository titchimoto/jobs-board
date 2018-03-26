class JobsController < ApplicationController
  include Pundit

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @jobs = Job.paginate(page: params[:page], per_page: 20)
    @user = current_user
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    authorize @job
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    authorize @job

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
    authorize @job
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
