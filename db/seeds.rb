# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Admin.create!(email: 'admin@sistemadefrete.com.br', password: '123456')

address = Address.new(full_address: '100, 1st street', city: 'New York', state: 'New York')
Company.create!(corporate_name: 'M Transports', trading_name: 'Monster Transports', registration_number: '1234567',
                address: address, email_domain: 'transportes.com.br', status: 'Ativa')

User.create!(email: 'user@transportes.com.br', password: '123456')

Product.create!(code: 'SKULG4580', height: '5.0', width: '14.0', depth: '21.0', weight: '100.0')
