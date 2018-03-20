class User < ApplicationRecord

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 1, maximum: 50 }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


end
