class Category < ApplicationRecord
  belongs_to :category, class_name: 'Category', optional: true
  has_many :categories, class_name: 'Category', dependent: :destroy
  belongs_to :admin
  has_many :products, dependent: :nullify

  enum status: { disabled: 0, active: 1 }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :category }

  def all_products(all_products = [], category = self)
    all_products.concat(category.products)
    category.categories.each do |children|
      all_products(all_products, children)
    end

    all_products
  end
end
