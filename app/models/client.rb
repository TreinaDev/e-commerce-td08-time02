class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :product_items, dependent: :nullify
  
  validates :name, :code, presence: true
  validate :code_is_valid

  def balance
    begin
      response = Faraday.get("http://localhost:4000/api/v1/balance/#{self.code_numbers}")
      body = JSON.parse(response.body)
      return body["balance"]
    rescue => exception
      return 0
    end
  end

  def code_numbers
    code.split('-').join.split('.').join.split('/').join
  end

  private

  def code_is_valid
    return unless code

    errors.add :code, 'inválido' if !CNPJ.valid?(code) && !CPF.valid?(code)
  end
end
