class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :subscriptions, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :proposals, through: :subscriptions
  has_many :chats, dependent: :nullify

  def send_on_create_confirmation_instructions
    # send_devise_notification(:confirmation_instructions)
  end

  def full_name
    profile.name
  end
end
