class Category < ApplicationRecord
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id', optional: true
  has_many :categories, class_name: 'Category', foreign_key: 'category_id'
  belongs_to :admin

  enum status: { disabled: 0, active: 1 }

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :category

  def full_name
    if category
      "#{category.name} > #{name}"
    else
      "#{name}"
    end
  end
end
