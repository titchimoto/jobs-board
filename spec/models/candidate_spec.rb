require 'rails_helper'

RSpec.describe Candidate, type: :model do
  let (:user) { User.create!(username: "Theocat", email: "theobear@meowmeow.com", password: "password", role: 0) }
  let (:other_user) { User.create!(username: "Moto", email: "motomoto@mototmoto.com", password: "password", role: 0) }
  let (:job) { Job.create!(title: "New Job Title", location: "Portland, OR", body: "This is the body of the job description", user: user) }
  let(:candidate) { Candidate.create!(body: "These are the reasons why you should consider me for this position...", job: job, user: user) }

    it { is_expected.to belong_to(:job) }
    it { is_expected.to belong_to(:user) }

    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:user) }

    it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    before do
      user.confirm
    end

    it "responds to body, job and user attributes" do
      expect(candidate).to have_attributes(body: "These are the reasons why you should consider me for this position...", job: job, user: user)
    end
  end

  describe "after_create" do
   before do
     @another_candidate = Candidate.new(body: 'Candidate body', job: job, user: other_user)
   end

   it "sends an email to the creator of the job listing" do
     candidate = user.candidates.create(job: job)
     expect(JobMailer).to receive(:new_candidate).with(job.user.email, job, @another_candidate).and_return(double(deliver_now: true))
     @another_candidate.save!
   end
 end

end
