# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(name: "jeremy", password: "hello").id
conv = Conversation.create!.id
Message.create!([{content: "hello", user_id: user, conversation_id: conv}, {content: "yo mama is ugly", user_id: user, conversation_id: conv}, {content: "I love mom", user_id: user, conversation_id: conv}])
