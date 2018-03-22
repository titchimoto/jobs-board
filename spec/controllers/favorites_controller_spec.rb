require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do

  let (:user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password", role: 0) }
  let (:job) { Job.create!(title: "New Job Title", location: "Portland, OR", body: "This is the body of the job description", user: user) }
  let (:favorite) { Favorite.create!(job: job, user: user) }

  context "guest user" do
    describe "POST create" do
      it "redirects the user to the sign in view" do
        post :create, params: { job_id: job.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirecst the user to the sign in view" do
        favorite = user.favorites.where(job: job).create
        delete :destroy, params: { job_id: job.id, id: favorite.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      user.confirm
      sign_in user
    end

    describe "POST create" do
      it "redirects to the jobs show view" do
        post :create, params: { job_id: job.id }
        expect(response).to redirect_to(job)
      end

      it "creates a favorite for the current user and specified job" do
        expect(user.favorites.find_by_job_id(job.id)).to be_nil
        post :create, params: { job_id: job.id }
        expect(user.favorites.find_by_job_id(job.id)).not_to be_nil
      end
    end

    describe "DELETE destroy" do
      it "redirects to the job show view" do
        favorite = user.favorites.where(job: job).create
        delete :destroy, params: { job_id: job.id, id: favorite.id }
        expect(response).to redirect_to(job)
      end

      it "destroys the favorite for the current user and specified job" do
        favorite = user.favorites.where(job: job).create
        expect(user.favorites.find_by_job_id(job.id)).not_to be_nil
        delete :destroy, params: { job_id: job.id, id: favorite.id }
        expect(user.favorites.find_by_job_id(job.id)).to be_nil
      end
    end




  end


end
