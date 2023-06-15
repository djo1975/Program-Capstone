# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
User.create(username: 'john_doe')
User.create(username: 'djo_doe')
User.create(username: 'alwyn_doe')
User.create(username: 'mohi_doe')
User.create(username: 'mosses_doe')
user = User.first # Pridružite odgovarajućeg korisnika
room = Room.first # Pridružite odgovarajuću sobu
comment = Comment.create(user:, room:, content: 'Example Comment')
Like.create(user:, comment:)
