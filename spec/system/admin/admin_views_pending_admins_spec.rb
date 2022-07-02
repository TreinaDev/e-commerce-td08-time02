require 'rails_helper'

describe 'Administrador vê os cadastros de administradores pendentes' do
  it 'a partir da tela inicial' do
    admin = create :admin
    create :admin, email: 'jose@mercadores.com.br', name: 'José', status: :pending
    create :admin, email: 'maria@mercadores.com.br', name: 'Maria', status: :pending
    create :admin, email: 'fernando@mercadores.com.br', name: 'Fernando', status: :approved

    login_as admin, scope: :admin
    visit root_path
    find('#menu-desktop').click_on 'Cadastros Pendentes'

    expect(page).to have_content 'Cadastros de Administradores pendentes'
    expect(page).to have_content "Nome\nJosé"
    expect(page).to have_content "E-mail\njose@mercadores.com.br"
    expect(page).to have_content "Nome\nMaria"
    expect(page).to have_content "E-mail\nmaria@mercadores.com.br"
    expect(page).not_to have_content "Nome\nFernando"
    expect(page).not_to have_content "E-mail\nfernando@mercadores.com.br"
  end

  it 'e aprova o cadastro de outro admin' do
    admin = create :admin, email: 'admin@mercadores.com.br', password: 'password', status: :approved
    first_pending_admin = create :admin, email: 'jose@mercadores.com.br', name: 'José', status: :pending
    create :admin, email: 'maria@mercadores.com.br', name: 'Maria', status: :pending

    login_as admin, scope: :admin
    visit pending_admins_path
    find("div##{first_pending_admin.id}").click_on 'Aprovar Cadastro'
    first_pending_admin.reload

    expect(page).to have_content('Administrador aprovado com sucesso.')
    expect(first_pending_admin.approved?).to be true
    expect(page).not_to have_content "Nome\nJosé"
    expect(page).not_to have_content "E-mail\njose@mercadores.com.br"
    expect(page).to have_content "Nome\nMaria"
    expect(page).to have_content "E-mail\nmaria@mercadores.com.br"
  end
end
