class Profile < ApplicationRecord
  has_one_attached :avatar
  validates :name, :birth_date, :document, :professional_resume, :scholarity,
            :candidate_id, :avatar, presence: true
  validates :document, cpf: { message: 'inválido. Verifique se inseriu '\
                                       'corretamente' }
  belongs_to :candidate
  has_many :comments, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :experiences, dependent: :destroy
  accepts_nested_attributes_for :addresses
end
