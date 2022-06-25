class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :product_items, dependent: :nullify

  validates :name, :code, presence: true
  validate :code_is_valid

  def balance
    response = Faraday.get("http://localhost:4000/api/v1/balance/#{code_numbers}")
    body = JSON.parse(response.body)
    body['balance']
  rescue
    0
  end

  def code_numbers
    code.split('-').join.split('.').join.split('/').join
  end

  def purchase_value
    product_items.sum(&:define_product_total_price)
  end

  def purchase_shipping_value
    product_items.sum(&:define_product_shipping_price)
  end

  private

  def code_is_valid
    return unless code

    errors.add :code, 'inválido' if !CNPJ.valid?(code) && !CPF.valid?(code)
  end
end
