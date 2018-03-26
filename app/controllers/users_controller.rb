class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user= User.find(params[:id])
    @user.assign_attributes(user_params)

    authorize @user


    if @user.save
      flash[:notice] = "Your profile was successfully updated."
      redirect_to @user
    else
      flash.now[:alert] = "There was an error updating your user profile. Please try again."
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:bio)

  end



end
