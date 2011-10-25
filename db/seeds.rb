# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

account = Account.new
account.name = "Test Account"
account.save

user = User.new
user.email = 'user@example.com'
user.password = user.password_confirmation = 'password'
user.account = account
user.save
user.confirm!
