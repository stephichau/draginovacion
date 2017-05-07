# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Measure.delete_all
User.delete_all

u = User.create(email: 'test@example.com', password: '123456', password_confirmation: '123456')
Measure.create(user: u, lat: 48.53960333333333, lng: 9.058988333333334, kind: 0, value: 1.23, color: '#ffffff')
Measure.create(user: u, lat: 48.53960333333333, lng: 9.058988333333334, kind: 1, value: 2.23, color: '#ffefff')
Measure.create(user: u, lat: 48.53960333333333, lng: 9.058988333333334, kind: 2, value: 3.23, color: '#fffafff')
Measure.create(user: u, lat: 48.53960333333333, lng: 9.058988333333334, kind: 3, value: 4.23, color: '#0fffdf')