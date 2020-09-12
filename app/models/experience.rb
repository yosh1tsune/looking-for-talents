class Experience < ApplicationRecord
  validates :company, :role, :resume, :start_date, presence: true
  validate :end_date_obligation
  belongs_to :profile

  def end_date_obligation
    self.end_date = nil if currently_working == true
    return unless end_date.blank? && currently_working == false

    errors.add(:end_date, 'Preencha a data de término do contrato ou informe '\
                          'que ainda neste emprego.')
  end
end
