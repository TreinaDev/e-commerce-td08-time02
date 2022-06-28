class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :product_items, dependent: :nullify

  validates :name, :code, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0.0 }
  validate :code_is_valid

  def code_numbers
    code.split('-').join.split('.').join.split('/').join
  end

  private

  def code_is_valid
    return unless code

    errors.add :code, 'inválido' if !CNPJ.valid?(code) && !CPF.valid?(code)
  end
end
