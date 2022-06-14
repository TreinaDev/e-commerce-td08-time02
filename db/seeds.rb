# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = Admin.create!(email: 'arthur@mercadores.com.br', password: 'password', name: 'Arthur', status: :approved)
Admin.create!(email: 'marco@mercadores.com.br', password: 'password', name: 'Marco')

category = Category.create!(name: 'Eletronicos', admin:)
Category.create!(name: 'Celulares', admin:, category:)
other_category = Category.create!(name: 'Roupas', admin:)
Category.create!(name: 'Camisetas', admin:, category:other_category)
