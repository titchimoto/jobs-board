class Job < ApplicationRecord

  default_scope { order('created_at DESC') }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :candidates, dependent: :destroy

  validates :title, length: { minimum: 5, maximum: 200 }, presence: true
  validates :location, length: { minimum: 3, maximum: 50 }, presence: true
  validates :body, length: { minimum: 25 }, presence: true
  validates :user, presence: true




end
