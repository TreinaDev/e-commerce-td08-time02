require 'rails_helper'

describe 'Cliente se cadastra' do
  it 'com sucesso' do
    client_data = { client_wallet: { email: 'james@outlook.com', registered_number: '29.498.318/0001-26' } }
    fake_response = instance_double(Faraday::Response, status: 201, body: '')
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/client_wallets',
                                          client_data).and_return fake_response

    visit root_path
    find('#menu-desktop').click_on('Entrar como Cliente')
    click_on('Registrar-se')
    fill_in('E-mail', with: 'james@outlook.com')
    fill_in('Senha', with: 'password')
    fill_in('Confirmar senha', with: 'password')
    fill_in('Nome', with: 'James')
    fill_in('CPF/CNPJ', with: '29.498.318/0001-26')
    click_on('Registrar-se')

    expect(page).to have_current_path root_path
    expect(page).to have_content('Cadastro efetuado com sucesso.')
    expect(page).not_to have_content('Entrar como Cliente')
    expect(page).to have_content('James (james@outlook.com)')
    expect(Client.count).to eq 1
    expect(Client.last.has_wallet).to be true
  end

  it 'com dados incompletos' do
    visit(new_client_registration_path)
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    fill_in 'Nome', with: ''
    fill_in 'CPF/CNPJ', with: ''
    click_on('Registrar-se')

    expect(Client.count).to eq 0
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'CPF/CNPJ não pode ficar em branco'
    expect(page).to have_current_path client_registration_path
    expect(page).not_to have_content 'Cadastro efetuado com sucesso.'
  end

  it 'e aplicação de Pagamentos está fora do ar' do
    allow(Faraday).to receive(:post).and_raise Faraday::ConnectionFailed

    visit new_client_registration_path
    fill_in('E-mail', with: 'james@outlook.com')
    fill_in('Senha', with: 'password')
    fill_in('Confirmar senha', with: 'password')
    fill_in('Nome', with: 'James')
    fill_in('CPF/CNPJ', with: '29.498.318/0001-26')
    click_on('Registrar-se')

    expect(page).to have_current_path root_path
    expect(page).to have_content('Cadastro efetuado com sucesso.')
    expect(page).to have_content('James (james@outlook.com)')
    expect(Client.count).to eq 1
    expect(Client.last.has_wallet).to be false
  end

  it 'e já existe uma carteira com seu código/e-mail em Pagamentos' do
    client_data = { client_wallet: { email: 'james@outlook.com', registered_number: '29.498.318/0001-26' } }
    response_json = [['cpf/cnpj em uso'], ['email em uso']].to_json
    fake_response = instance_double(Faraday::Response, status: 412, body: response_json)
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/client_wallets',
                                          client_data).and_return(fake_response)

    visit new_client_registration_path
    fill_in('E-mail', with: 'james@outlook.com')
    fill_in('Senha', with: 'password')
    fill_in('Confirmar senha', with: 'password')
    fill_in('Nome', with: 'James')
    fill_in('CPF/CNPJ', with: '29.498.318/0001-26')
    click_on('Registrar-se')

    expect(page).to have_current_path root_path
    expect(page).to have_content('Cadastro efetuado com sucesso.')
    expect(page).to have_content('James (james@outlook.com)')
    expect(Client.count).to eq 1
    expect(Client.last.has_wallet).to be true
  end
end
