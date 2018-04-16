# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


justin = User.create(name: "Justin", username: "jdumadag", password: "password")
remy = User.create(name: "Jeremy", username: "jerbear", password: "password")
christian = User.create(name: "Christian", username: "queeshon", password: "password")

convo1= Conversation.create()
