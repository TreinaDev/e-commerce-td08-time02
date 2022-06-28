require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#valid' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:code) }

    describe '.code_is_valid' do
      it 'verdadeiro se CPF é válido' do
        client = described_class.new(code: '510.808.180-49')
        client.valid?
        expect(client.errors.include?(:code)).to be false
      end

      it 'falso se CPF não é válido' do
        client = described_class.new(code: '50.88.180-49')
        client.valid?
        expect(client.errors[:code]).to include 'inválido'
      end

      it 'verdadeiro se CNPJ é válido' do
        client = described_class.new(code: '82.425.181/0001-62')
        client.valid?

        expect(client.errors.include?(:code)).to be false
      end

      it 'falso se CNPJ não é válido' do
        client = described_class.new(code: '823.425.181/0001-62')
        client.valid?

        expect(client.errors[:code]).to include 'inválido'
      end
    end
  end
  
  describe '.code_numbers' do
    it 'remove caracteres especiais do code com sucesso' do
      client = create(:client, code: '82.425.181/0001-62')

      expect(client.code_numbers).to eq '82425181000162'
    end
  end
end
