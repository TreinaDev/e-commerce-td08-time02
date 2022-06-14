class Category < ApplicationRecord
  belongs_to :category, class_name: 'Category', optional: true
  has_many :categories, class_name: 'Category', dependent: :destroy
  belongs_to :admin

  enum status: { disabled: 0, active: 1 }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :category }
end
