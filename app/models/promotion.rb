class Promotion < ApplicationRecord
  has_many :categories
  belongs_to :admin

  validates :start_date, :end_date, :name, :discount_max, :discount_percentual, :used_times, :usage_limit, presence: true
  validates :usage_limit, :discount_max, :discount_percentual, numericality: { greater_than: 0 }
  validates :used_times, numericality: { greater_than_or_equal_to: 0 }
  validates :coupon, uniqueness: true
  validate :start_date_before_end_date
  validate :start_date_greater_than_today
  validate :usage_limit_is_greater_or_equal_to_used_times

  before_validation :generate_coupon, on: :create

  def is_valid_status
    if Date.today < start_date 
      'Futura'
    elsif Date.today > end_date
      'Expirada'
    else
      'Vigente'
    end
  end

  private

  def generate_coupon
    self.coupon = SecureRandom.alphanumeric(8).upcase
  end

  def usage_limit_is_greater_or_equal_to_used_times
    return unless usage_limit && used_times

    return if usage_limit >= used_times

    errors.add :used_times, message: 'não pode ser maior que o limite de usos'
  end

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
end
