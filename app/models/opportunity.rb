class Opportunity < ApplicationRecord
  validates :title, :work_description, :required_abilities, :salary, :grade,
            :submit_end_date, :company, presence: true
  validate :date_validator
  belongs_to :headhunter
  has_one :address
  accepts_nested_attributes_for :address
  has_many :subscriptions, dependent: :destroy
  has_many :candidates, through: :subscriptions
  has_many :proposals, dependent: :destroy

  enum status: { open: 0, closed: 1 }

  def date_validator
    return if submit_end_date.blank?

    return unless submit_end_date < 6.days.from_now

    errors.add(:submit_end_date, 'deve ser ao menos daqui a 7 dias')
  end
end
