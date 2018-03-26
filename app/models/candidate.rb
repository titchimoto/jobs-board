class Candidate < ApplicationRecord
  belongs_to :job
  belongs_to :user

  validates :body, length: { minimum: 5, maximum: 500 }, presence: true
  validates :user, presence: true
end
