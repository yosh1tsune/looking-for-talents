class Proposal < ApplicationRecord
  validates :start_date, :salary, :role, :benefits, :expectations,
            :bonuses, presence: true
  validate :start_date_validator
  belongs_to :subscription
  belongs_to :opportunity
  has_one :headhunter, through: :opportunity
  has_one :candidate, through: :subscription
  has_one :company, through: :opportunity

  enum status: { in_progress: 0, accepted: 1, refused: 2 }

  def start_date_validator
    return if start_date.blank?

    return unless start_date < 13.days.from_now

    errors.add(:start_date, 'deve ser ao menos daqui a 14 dias. '\
                            'O candidato precisa se preparar!')
  end
end
