class ExchangeRate < ApplicationRecord
  validates :value, presence: true

  after_create :delete_old_rate

  private

  def delete_old_rate
    rates = ExchangeRate.all - [self]
    rates.each(&:delete)
  end
end
