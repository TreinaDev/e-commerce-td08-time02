class Category < ApplicationRecord
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id', optional: true
  has_many :categories, class_name: 'Category', foreign_key: 'category_id'
end
