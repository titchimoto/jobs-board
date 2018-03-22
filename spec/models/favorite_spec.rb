require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let (:user) { User.create!(username: "Theobear", email: "theo@meowmeowmeow.com", password: "password", role: 0).confirm }
  let (:job) { Job.create!(title: "New Job Title", location: "Portland, OR", body: "This is the body of the job description", user: user) }
  let (:favorite) { Favorite.create!(job: job, user: user) }


  it { is_expected.to belong_to (:job) }
  it { is_expected.to belong_to (:user) }






end
