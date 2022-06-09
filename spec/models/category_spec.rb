require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid' do
    it 'falso quando nome está vazio' do
      category = described_class.new

      expect(category).not_to be_valid
      expect(category.errors).to include :name
    end

    it 'falso quando o nome se repete na mesma super categoria' do
      admin = Admin.create!(email: 'joão@mercadores.com.br', password: 'joão1234', status: :approved)
      category = described_class.create!(name: 'Eletronicos', admin:)
      described_class.create!(name: 'Celulares', admin:, category:)
      other_category = described_class.new(name: 'Celulares', admin:, category:)

      expect(other_category).not_to be_valid
      expect(other_category.errors).to include :name
    end

    it 'verdadeiro quando o nome não se repete' do
      admin = Admin.create!(email: 'joão@mercadores.com.br', password: 'joão1234', status: :approved)
      category = described_class.create!(name: 'Eletronicos', admin:)
      described_class.create!(name: 'Celulares', admin:, category:)
      other_category = described_class.new(name: 'Computadores', admin:, category:)

      expect(other_category).to be_valid
    end
  end
end
