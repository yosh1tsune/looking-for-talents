class Headhunter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  validates :name, :surname, presence: true
  has_many :opportunities, dependent: :destroy
  has_many :proposals, through: :opportunities
  has_many :comments, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :servicing_headhunters, dependent: :nullify
  has_many :linked_companies, through: :servicing_headhunters,
                              dependent: :destroy, source: :company

  def details
    "#{name} #{surname} - #{email}"
  end
end
