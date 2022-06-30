class Purchase < ApplicationRecord
  belongs_to :client
  has_many :product_items, dependent: :nullify
  enum status: { pending: 0, approved: 5, rejected: 10 }

  validates :code, uniqueness: true
  validates :cashback_value, numericality: { greater_than_or_equal_to: 0.0 }
  validates :value, numericality: { greater_than_or_equal_to: 0.0 }
  validate :cashback_value_less_than_or_equal_to_value

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def cashback_value_less_than_or_equal_to_value
    return unless cashback_value && value && value < cashback_value

    errors.add :value, message: 'não pode ser menor que o valor de cashback'
  end
end
