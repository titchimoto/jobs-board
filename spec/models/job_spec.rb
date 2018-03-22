require 'rails_helper'

RSpec.describe Job, type: :model do
  let (:user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password").confirm }
  let (:job) { Job.create!(title: "New Job Title", location: "Portland, OR", body: "This is the body of the job description", user: user) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:location) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(25) }



  describe "attributes" do
    it "has a title attribute" do
      expect(job).to have_attributes(title: "New Job Title")
    end

    it "has a location attribute" do
      expect(job).to have_attributes(location: "Portland, OR")
    end

    it "has a body attribute" do
      expect(job).to have_attributes(body: "This is the body of the job description")
    end

    it "has a user attribute" do
      expect(job).to have_attributes(user: user)
    end
  end

end
