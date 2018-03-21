require 'rails_helper'

RSpec.describe Job, type: :model do
  let (:job) { Job.create!(title: "New Job Title", location: "Portland, OR", body: "This is the body of the job description") }

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
  end

end
