# db/seeds.rb

# Ovo će očistiti postojeće podatke iz tabela prije dodavanja novih podataka

User.destroy_all
Room.destroy_all

# Dodajemo korisnika
user = User.create(username: 'john_doe')

# Dodajemo sobu i povezujemo je s korisnikom
room = Room.create(
  name: 'Soba 1',
  icon: 'icon.png',
  description: 'Ovo je opis sobe 1',
  cost_per_day: 100.0
)

# Dodajemo rezervaciju
user.reservations.create(
  start_date: Date.today,
  end_date: Date.today + 7,
  description: 'Moja rezervacija',
  room:,
  user:
)

# Dodajemo komentar
comment = user.comments.create(
  content: 'Ovo je komentar',
  room:
)

# Dodajemo lajk
user.likes.create(
  comment:
)

puts 'Seed data created successfully!'
