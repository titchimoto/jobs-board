class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    job = Job.find(params[:job_id])
    favorite = current_user.favorites.build(job: job)

    if favorite.save
      flash[:notice] = "Job added to Favorites."
    else
      flash[:alert] = "Error adding job to Favorites. Please try again."
    end
    redirect_to job
  end

  def destroy
    job = Job.find(params[:job_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Job successfully removed from Favorites."
    else
      flash[:alert] = "Error removing job from Favorites. Please try again."
    end
    redirect_to job
  end


end
