require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password").confirm }


  describe "attributes" do
    it "should have have a username attribute" do
      expect(user).to have_attributes(username: user.username)
    end
  end

end
