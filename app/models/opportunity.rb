class Opportunity < ApplicationRecord
    validates :title, :work_description, :required_abilities, :salary, :grade, :address, :submit_end_date, :company, presence: true
    belongs_to :headhunter
    has_many :candidate_registrations
    has_many :candidates, through: :candidate_registrations

    enum status: [:open, :closed]
end
