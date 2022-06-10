require 'rails_helper'

describe 'Usuário não é administrador autenticado' do
  it 'e tenta ver cadastros pendentes' do
    get pending_admins_path

    expect(response).to redirect_to new_admin_session_path
  end

  it 'e tenta autorizar cadastro pendente' do
    admin = create :admin, status: :pending

    post approve_pending_admin_path(admin.id)

    expect(response).to redirect_to new_admin_session_path
  end
end
