class Job < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, length: { minimum: 5, maximum: 200 }, presence: true
  validates :location, length: { minimum: 3, maximum: 50 }, presence: true
  validates :body, length: { minimum: 25 }, presence: true
  validates :user, presence: true




end
