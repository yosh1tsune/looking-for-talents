class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :subscriptions, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :proposals, through: :subscriptions
end
