require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  let (:user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password", role: 0) }
  let(:my_job) { Job.create!(title: "This is a new job", location: "Portland, OR", body: "This is a new job description", user: user) }

 context "user" do
   before do
     user.confirm
     sign_in user
   end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns [my_job] to @jobs" do
        get :index
        expect(assigns(:jobs)).to eq([my_job])
      end
    end


    describe "GET #show" do
      it "returns http success" do
        get :show, params: { id: my_job.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: my_job.id }
        expect(response).to render_template :show
      end

      it "assigns my_job to @job" do
        get :show, params: { id: my_job.id }
        expect(assigns(:job)).to eq(my_job)
        end
    end



    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @job" do
        get :new
        expect(assigns(:job)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Job by 1" do
        expect{ post :create, params: { job: { title: "This is a new job", location: "Portland, OR", body: "This is a new job description" } } }.to change(Job,:count).by(1)
      end

      it "assigns the new job to @job" do
        post :create, params: { job: { title: "This is a new job", location: "Portland, OR", body: "This is a new job description" } }
        expect(assigns(:job)).to eq Job.last
      end

      it "redirects to the new job" do
        post :create, params: { job: { title: "This is a new job", location: "Portland, OR", body: "This is a new job description" } }
        expect(response).to redirect_to Job.last
      end
    end




    describe "GET #edit" do
      it "returns http success" do
        get :edit, params: { id: my_job.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: my_job.id }
        expect(response).to render_template :edit
      end

      it "assigns job to be updated to @job" do
        get :edit, params: { id: my_job.id }
        job_instance = assigns(:job)

        expect(job_instance.id).to eq my_job.id
        expect(job_instance.title).to eq my_job.title
        expect(job_instance.location).to eq my_job.location
        expect(job_instance.body).to eq my_job.body
      end
    end

    describe "PUT update" do
      it "updates the job with the expected attributes" do
        new_title = "This is the new job title"
        new_location = "New Location, OR"
        new_body = "This is the new job listing body"

        put :update, params: { id: my_job.id, job: { title: new_title, location: new_location, body: new_body } }

        updated_job = assigns(:job)
        expect(updated_job.id).to eq my_job.id
        expect(updated_job.title).to eq new_title
        expect(updated_job.location).to eq new_location
        expect(updated_job.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = "This is the new job title"
        new_location = "New Location, OR"
        new_body = "This is the new job listing body"

        put :update, params: { id: my_job.id, job: { title: new_title, location: new_location, body: new_body } }
        expect(response).to redirect_to my_job
      end
    end

    describe "DELETE destroy" do
      it "deletes the job" do
        delete :destroy, params: { id: my_job.id }
        count = Job.where({ id: my_job.id }).size
        expect(count).to eq 0
      end

      it "redirects to jobs index" do
        delete :destroy, params: { id: my_job.id }
        expect(response).to redirect_to jobs_path
      end
    end

  end

end
