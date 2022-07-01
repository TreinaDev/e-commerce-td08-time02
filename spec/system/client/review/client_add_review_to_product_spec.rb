require 'rails_helper'

describe 'Cliente adiciona uma avaliação' do
  it 'com sucesso' do
    client = create :client
    product = create(:product, name: 'Monitor 8k', status: :active)
    create(:price, product: product, admin: product.category.admin, start_date: Time.zone.today,
                   end_date: 90.days.from_now, value: 1500.00)

    login_as client, scope: :client
    visit root_path
    click_on 'Monitor 8k'
    click_on 'Faça sua avaliação'
    find("#one").choose()
    fill_in 'Comentário', with: 'Excelente produto. Recomendo!'
    click_on 'cadastrar'

    expect(Review.all.length).to eq 1
    expect(Review.last.rating).to eq 1
    expect(Review.last.comment).to eq 'Excelente produto. Recomendo!'
  end

  it 'com falha' do
    client = create :client
    product = create(:product, name: 'Monitor 8k', status: :active)
    create(:price, product: product, admin: product.category.admin, start_date: Time.zone.today,
                   end_date: 90.days.from_now, value: 1500.00)

    login_as client, scope: :client
    visit root_path
    click_on 'Monitor 8k'
    click_on 'Faça sua avaliação'
    fill_in 'Comentário', with: ''
    click_on 'cadastrar'

    expect(page).to have_content 'Não foi possível postar a Avaliação'
    expect(page).to have_content 'Nota não pode ficar em branco'
    expect(page).to have_content 'Comentário não pode ficar em branco'

    expect(page).to have_current_path product_reviews_path(product)
  end
end
