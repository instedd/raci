# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(email: 'admin@instedd.org',
  name: 'Administrator',
  password: '12345678',
  password_confirmation: '12345678',
  confirmed_at: DateTime.now,
  admin: true)

org_user = User.create(email: 'user@ngo.org',
  name: 'NGO project manager',
  password: '12345678',
  password_confirmation: '12345678',
  confirmed_at: DateTime.now)

Organization.create(name: "NGO", twitter: "@ngo", email: "info@ngo.org", user: org_user)
