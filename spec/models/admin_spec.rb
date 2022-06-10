require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it 'falso se domínio de e-mail estiver incorreto' do
      admin = described_class.new(email: 'admin@mercadoras.com.br')

      admin.valid?

      expect(admin.errors[:email]).to include 'não é válido'
    end

    it 'verdadeiro se domínio de e-mail estiver correto' do
      admin = described_class.new(email: 'admin@mercadores.com.br')

      admin.valid?

      expect(admin.errors.include?(:email)).to be false
    end
  end
end
