require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do
  let(:my_user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password", role: 0) }
  let(:other_user) { User.create!(username: "Theocat", email: "theocat@meowmeowmeow.com", password: "password", role: 0)}
  let(:my_job) { Job.create!(title: "New Job Title", location: "Portland, OR", body: "This is the body of the job description", user: my_user) }
  let(:my_candidate) { Candidate.create!(body: 'This is why you should consider me for this position...', job: my_job, user: my_user) }

     context "guest" do
       describe "POST create" do
         it "redirects the user to the sign in view" do
           post :create, params: { job_id: my_job.id, candidate: { body: Faker::Lorem.paragraph(5) } }
           expect(response).to redirect_to(new_user_session_path)
         end
       end

       describe "DELETE destroy" do
         it "redirects the user to the sign in view" do
           delete :destroy, params: { job_id: my_job.id, id: my_candidate.id }
           expect(response).to redirect_to(new_user_session_path)
         end
       end
     end

     context "member user doing CRUD on a candidate they don't own" do
       before do
         other_user.confirm
         sign_in other_user
       end

       describe "POST create" do
         it "increases the number of candidates by 1" do
           expect{ post :create, params: { job_id: my_job.id, candidate: {body: Faker::Lorem.paragraph(5)} } }.to change(Candidate,:count).by(1)
         end

         it "redirects to the post show view" do
           post :create, params: { job_id: my_job.id, candidate: {body: Faker::Lorem.paragraph(5)} }
           expect(response).to redirect_to my_job
         end
       end

       describe "DELETE destroy" do
         it "redirects the user to the posts show view" do
           delete :destroy, params: { job_id: my_job.id, id: my_candidate.id }
           expect(response).to redirect_to(my_job)
         end
       end
     end


     context "member user doing CRUD on a candidate they own" do
       before do
         my_user.confirm
         sign_in my_user
       end

       describe "POST create" do
         it "increases the number of candidates by 1" do
           expect{ post :create, params: { job_id: my_job.id, candidate: {body: Faker::Lorem.paragraph(5)} } }.to change(Candidate,:count).by(1)
         end

         it "redirects to the post show view" do
           post :create, params: { job_id: my_job.id, candidate: {body: Faker::Lorem.paragraph(5)} }
           expect(response).to redirect_to my_job
         end
       end

       describe "DELETE destroy" do
         it "deletes the candidate" do
           delete :destroy, params: { job_id: my_job.id, id: my_candidate.id }
           count = Candidate.where({id: my_candidate.id}).count
           expect(count).to eq 0
         end

         it "redirects to the post show view" do
           delete :destroy, params: { job_id: my_job.id, id: my_candidate.id }
           expect(response).to redirect_to my_job
         end
       end
     end

     context "admin user doing CRUD on a candidate they don't own" do
       before do
         other_user.confirm
         sign_in other_user
         other_user.admin!
       end

       describe "POST create" do
         it "increases the number of candidates by 1" do
           expect{ post :create, params: { job_id: my_job.id, candidate: {body: Faker::Lorem.paragraph(5)} } }.to change(Candidate,:count).by(1)
         end

         it "redirects to the post show view" do
           post :create, params: { job_id: my_job.id, candidate: {body: Faker::Lorem.paragraph(5)} }
           expect(response).to redirect_to my_job
         end
       end

       describe "DELETE destroy" do
         it "deletes the candidate" do
           delete :destroy, params: { job_id: my_job.id, id: my_candidate.id }
           count = Candidate.where({id: my_candidate.id}).count
           expect(count).to eq 0
         end

         it "redirects to the post show view" do
           delete :destroy, params: { job_id: my_job.id, id: my_candidate.id }
           expect(response).to redirect_to my_job
         end
       end
     end
  end
