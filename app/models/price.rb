class Price < ApplicationRecord
  belongs_to :admin
  belongs_to :product

  validates :value, :start_date, :end_date, presence: true
  validates :value, numericality: { greater_than: 0.0 }
  validate :start_date_before_end_date
  validate :start_date_greater_than_today
  validate :not_previously_registered

  private

  def start_date_before_end_date
    return unless start_date && end_date

    return if start_date < end_date

    errors.add :start_date, message: 'não pode ser maior que a data final'
  end

  def start_date_greater_than_today
    return unless start_date

    return if start_date >= Date.today

    errors.add :start_date, message: 'não pode ser anterior a hoje'
  end

  def not_previously_registered
    return unless product && start_date && end_date

    product.prices.each do |price|
      next if price == self

      interval = (price.start_date..price.end_date)
      message = 'não pode estar inclusa em intervalo já cadastrado'
      errors.add(:start_date, message) if interval.include? start_date
      errors.add(:end_date, message) if interval.include? end_date
    end
  end
end
