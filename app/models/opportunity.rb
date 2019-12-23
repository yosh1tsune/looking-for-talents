class Opportunity < ApplicationRecord
    validates :title, :work_description, :required_abilities, :salary, :grade, :address, :submit_end_date, presence: true
    has_many :registrations
    has_many :candidates, through: :registrations
end
