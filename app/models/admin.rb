class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories
  enum status: { pending: 0, approved: 5 }, _default: :pending

  validates :name, presence: true
  validate :domain_is_correct

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

  private

  def domain_is_correct
    return unless email

    domain = email.split('@').last
    errors.add :email, message: 'não é válido' if domain != 'mercadores.com.br'
  end
end
