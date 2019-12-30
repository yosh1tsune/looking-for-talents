class Opportunity < ApplicationRecord
    validates :title, :work_description, :required_abilities, :salary, :grade, :address, :submit_end_date, :company, presence: true
    validate :date_validator
    belongs_to :headhunter
    has_many :subscriptions
    has_many :candidates, through: :subscriptions
    has_many :proposals

    enum status: [:open, :closed]

    def date_validator
        return unless submit_end_date.present?

        if submit_end_date < 6.days.from_now
            errors.add(:submit_end_date, 'deve ser ao menos daqui a 7 dias')            
        end
    end
end