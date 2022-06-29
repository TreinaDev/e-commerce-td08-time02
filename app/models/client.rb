class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :product_items, dependent: :nullify
  
  validates :name, :code, presence: true
  validate :code_is_valid

  after_create :create_wallet

  def code_numbers
    code.split('-').join.split('.').join.split('/').join
  end

  private

  def create_wallet
    begin
      params = { client_wallet: { email:, registered_number: code } }
      response = Faraday.post('http://localhost:4000/api/v1/client_wallets', params)

      if response.status.digits.last == 2 || response.body.include?('em uso')
        self.update(has_wallet: true)
      end
    end
  end

  def code_is_valid
    return unless code

    return if CNPJ.valid?(code) || CPF.valid?(code) && code.include?('.')

    errors.add :code, 'inválido'
  end
end
