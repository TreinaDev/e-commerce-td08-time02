require 'rails_helper'

describe 'Visitante não autenticado' do
  it 'tenta confirmar compra' do
    post purchases_path

    expect(response).to redirect_to new_client_session_path
    expect(Purchase.count).to eq 0
  end
end
