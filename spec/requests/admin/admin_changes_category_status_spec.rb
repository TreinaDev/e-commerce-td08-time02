require 'rails_helper'

describe 'Administrador muda status de categoria' do
  it 'para ativo' do
    admin = create :admin
    category = create(:category, admin:, status: :disabled)

    login_as admin, scope: :admin
    post activate_category_path(category.id)
    category.reload

    expect(response).to redirect_to category_path(category.id)
    expect(category).to be_active
  end

  it 'para desativado' do
    admin = create :admin
    category = create(:category, admin:, status: :active)

    login_as admin, scope: :admin
    post deactivate_category_path(category.id)
    category.reload

    expect(response).to redirect_to category_path(category.id)
    expect(category).to be_disabled
  end
end
