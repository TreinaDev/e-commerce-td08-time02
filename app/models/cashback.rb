class Cashback < ApplicationRecord
  belongs_to :admin
  has_many :products

  validates :start_date, :end_date, :percentual, presence: true
  validates :percentual, numericality: { greater_than: 0 }
  validate :start_date_before_end_date
  validate :start_date_greater_than_today

  def start_date_before_end_date
    return unless start_date && end_date

    return if start_date < end_date

    errors.add :start_date, message: 'não pode ser maior que a data final'
  end

  def start_date_greater_than_today
    return unless start_date

    return if start_date >= Time.zone.today

    errors.add :start_date, message: 'não pode ser anterior a hoje'
  end

  def extended_description
    "#{percentual}% |  #{start_date.strftime('%d/%m')} - #{end_date.strftime('%d/%m')}"
  end
end
