class Category < ApplicationRecord
  belongs_to :promotion, optional: true
  belongs_to :admin
  belongs_to :category, class_name: 'Category', optional: true
  has_many :categories, class_name: 'Category', dependent: :destroy
  has_many :products, dependent: :nullify

  enum status: { active: 0, disabled: 1 }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :category }

  def all_products(admin, all_products = [], category = self)
    admin ? all_products.concat(category.products) : all_products.concat(category.products.active)
    category.categories.each do |children|
      all_products(admin, all_products, children)
    end

    all_products
  end
end
