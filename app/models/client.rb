class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :product_items, dependent: :nullify
  has_many :purchases, dependent: :nullify
  has_many :reviews, dependent: :nullify

  validates :name, :code, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0.0 }
  validate :code_is_valid

  after_create :create_wallet

  def code_numbers
    code.split('-').join.split('.').join.split('/').join
  end

  def purchase_value
    product_items.sum(&:total_price)
  end

  def purchase_shipping_value
    product_items.sum(&:total_shipping_price)
  end

  def purchase_cashback_value
    product_items.sum(&:cashback_value)
  end

  private

  def create_wallet
    params = { client_wallet: { email: email, registered_number: code } }
    response = Faraday.post('http://localhost:4000/api/v1/client_wallets', params)
    update(has_wallet: true) if response.status.digits.last == 2 || response.body.include?('em uso')
  rescue Faraday::ConnectionFailed
    update(has_wallet: false)
  end

  def code_is_valid
    return unless code

    return if (CNPJ.valid?(code) || CPF.valid?(code)) && code.include?('.')

    errors.add :code, 'inválido'
  end
end
