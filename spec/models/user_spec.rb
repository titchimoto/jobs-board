require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password", role: 0) }

  it { is_expected.to have_many(:favorites) }
  it { is_expected.to have_many(:jobs) }


  describe "attributes" do
    before do
      user.confirm
    end

    it "should have have a username attribute" do
      expect(user).to have_attributes(username: user.username)
    end
  end


  describe "#favorite_for(job)" do
    before do
      @job = Job.create!(title: "New Job Title", location: "Portland, OR", body: "This is the body of the job description", user: user)
    end

    it "returns nil if the user has not favorited the post" do
      expect(user.favorite_for(@job)).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      favorite = user.favorites.where(job: @job).create
      expect(user.favorite_for(@job)).to eq(favorite)
    end
  end


  

end
