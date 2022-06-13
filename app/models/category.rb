class Category < ApplicationRecord
  belongs_to :category, class_name: 'Category', optional: true
  has_many :categories, class_name: 'Category', dependent: :destroy
  belongs_to :admin

  enum status: { disabled: 0, active: 1 }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :category }

  def full_name(curr_category = self, string = '')
    string.insert(0, curr_category.name)
    return self.full_name(curr_category.category, ' > ' + string) if curr_category.category
    string
  end
end
