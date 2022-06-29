require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid' do
    it { is_expected.to validate_presence_of(:name) }

    it 'falso quando o nome se repete na mesma super categoria' do
      admin = create(:admin)
      category = described_class.create!(name: 'Eletrônicos', admin:)
      described_class.create!(name: 'Celulares', admin:, category:)
      other_category = described_class.new(name: 'Celulares', admin:, category:)

      expect(other_category).not_to be_valid
      expect(other_category.errors).to include :name
    end

    it 'verdadeiro quando o nome não se repete' do
      admin = create(:admin)
      category = described_class.create!(name: 'Eletrônicos', admin:)
      described_class.create!(name: 'Celulares', admin:, category:)
      other_category = described_class.new(name: 'Computadores', admin:, category:)

      expect(other_category).to be_valid
    end
  end

  describe '#all_products' do
    it 'retorna produtos ativos e inativos de uma categoria e de suas descendentes se admin' do
      create :exchange_rate
      first_category = create :category, name: 'Roupas'
      second_category = create :category, name: 'Tocas', category: first_category
      third_category = create :category, name: 'Tocas de algodão', category: second_category
      fourth_category = create :category, name: 'Camisetas', category: first_category
      fifth_category = create :category, name: 'Brinquedos'
      active_product1 = create :product, name: 'Shorts Branco', category: first_category,
                                         description: 'Short branco do Palmeiras 2022', status: :active
      active_product2 = create :product, name: 'Camiseta Azul', category: fourth_category,
                                         description: 'Camiseta do Cruzeiro 2021', status: :active
      active_product3 = create :product, name: 'Rampa da HotWeels', category: fifth_category,
                                         description: 'Rampa destroi carros', status: :active
      inactive_product_1  = create :product, name: 'Camiseta Vermelha', category: fourth_category,
                                         description: 'Camiseta do Flamengo 2022', status: :inactive
      inactive_product_2 = create :product, name: 'Toca do Cruzeiro', category: second_category,
                                         description: 'Toca do Cruzeiro 2022', status: :inactive
      admin = true

      products = first_category.all_products(admin)

      expect(products.sort).to eq [active_product1, active_product2, inactive_product_1, inactive_product_2].sort
    end

    it 'retorna somente produtos ativos de uma categoria e de suas descendentes se não admin' do
      create :exchange_rate
      first_category = create :category, name: 'Roupas'
      second_category = create :category, name: 'Tocas', category: first_category
      third_category = create :category, name: 'Tocas de algodão', category: second_category
      fourth_category = create :category, name: 'Camisetas', category: first_category
      fifth_category = create :category, name: 'Brinquedos'
      active_product1 = create :product, name: 'Shorts Branco', category: first_category,
                                         description: 'Short branco do Palmeiras 2022', status: :active
      active_product2 = create :product, name: 'Camiseta Azul', category: fourth_category,
                                         description: 'Camiseta do Cruzeiro 2021', status: :active
      active_product3 = create :product, name: 'Rampa da HotWeels', category: fifth_category,
                                         description: 'Rampa destroi carros', status: :active
      inactive_product_1 = create :product, name: 'Camiseta Vermelha', category: fourth_category,
                                         description: 'Camiseta do Flamengo 2022', status: :inactive
      inactive_product_2 = create :product, name: 'Toca do Cruzeiro', category: second_category,
                                         description: 'Toca do Cruzeiro 2022', status: :inactive
      admin = false

      products = first_category.all_products(admin)

      expect(products.sort).to eq [active_product1, active_product2].sort
    end
  end
end
