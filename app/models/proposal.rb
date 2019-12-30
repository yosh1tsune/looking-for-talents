class Proposal < ApplicationRecord
  validates :start_date, :salary, :role, :benefits, :expectations, :bonuses, presence: true
  validate :start_date_validator
  belongs_to :subscription
  belongs_to :opportunity
  has_one :headhunter, through: :opportunity
  has_one :candidate, through: :subscription

  enum status: [:in_progress, :accepted, :refused]

  def start_date_validator
    return unless start_date.present?

    if start_date < 13.days.from_now
      errors.add(:start_date, 'deve ser ao menos daqui a 14 dias. O candidato precisa se preparar!')
    end
  end
end
