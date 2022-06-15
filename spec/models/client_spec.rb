require 'rails_helper'

RSpec.describe Client, type: :model do
    describe '#valid' do
        it { should validate_presence_of(:name) }
        
        it { should validate_presence_of(:code) }

        context '.code_is_valid' do
          it 'verdadeiro se CPF é válido' do
            client = Client.new(code: '510.808.180-49')

            client.valid?

            expect(client.errors.include?(:code)).to be false
          end

          it 'falso se CPF não é válido' do
            client = Client.new(code: '50.88.180-49')

            client.valid?

            expect(client.errors[:code]).to include 'inválido'
          end

          it 'verdadeiro se CNPJ é válido' do
            client = Client.new(code: '82.425.181/0001-62')

            client.valid?
            
            expect(client.errors.include?(:code)).to be false
          end

          it 'falso se CNPJ não é válido' do
            client = Client.new(code: '823.425.181/0001-62')

            client.valid?
            
            expect(client.errors[:code]).to include 'inválido'
          end
        end
    end
end
