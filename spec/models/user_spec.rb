require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password", role: 0) }
  let(:known_user) { User.create!(username: "Theobear", email: "blochead@bloc.io", password: "password", role: 0) }


  it { is_expected.to have_many(:favorites) }
  it { is_expected.to have_many(:jobs) }


  describe "attributes" do
    before do
      user.confirm
    end

    it "should have have a username attribute" do
      expect(user).to have_attributes(username: user.username)
    end

    it "should have have an email attribute" do
      expect(user).to have_attributes(email: user.email)
    end

    it "should have have a role attribute" do
      expect(user).to have_attributes(role: user.role)
    end
  end

  describe "roles" do
    before do
      user.confirm
    end

    it "should be standard by default" do
      expect(user.role).to eq("standard")
    end

    it "should return true for #standard" do
      user.standard!
      expect(user.role).to eq("standard")
      expect(user.standard?).to be_truthy
    end

    it "should return true for #employer" do
      user.employer!
      expect(user.role).to eq("employer")
      expect(user.employer?).to be_truthy
    end

    it "should return true for #admin" do
      user.admin!
      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
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

  describe ".avatar_url" do
    before do
      known_user.confirm
    end

    it "returns the proper Gravatar url for a known email" do
      expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
      expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
  end


end
