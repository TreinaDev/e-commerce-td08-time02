require 'rails_helper'

describe 'Cliente sai do sistema' do
  it 'com sucesso' do
    client = create :client, name: 'Zé', email: 'cliente@hotmail.com'

    login_as client, scope: :client
    visit root_path
    click_on 'Sair'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Saída efetuada com sucesso.'
    expect(page).not_to have_content ' (cliente@hotmail.com)'
    expect(page).to have_link 'Entrar como Cliente'
  end
end
