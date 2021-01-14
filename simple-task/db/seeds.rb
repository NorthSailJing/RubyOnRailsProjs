require 'faker'

User.destroy_all
Client.destroy_all

user = User.create(email: "jing@northsail.io", password: "wjl113", admin: true)
User.create(email: "test@northsail.io", password: "wjl113", admin: false)

p "Created #{User.count} user(s)"

clients = []
c1 = Client.create(name: "NorthSail", bill_rate: 100)
clients << c1
c2 = Client.create(name: "Molson", bill_rate: 90)
clients << c2
c3 = Client.create(name: "Merge", bill_rate: 80)
clients << c3

p "Created #{Client.count} client(s)"

tks = []
30.times {
tks << {
  title: Faker::Lorem.words(rand(3..10)).join(' '), 
  body: Faker::Lorem.paragraph(sentence_count: rand(1..3)),
  client_id: clients.sample.id,
  duration: rand(1..100),
  status: rand(0..1),
  entered_on: rand(1..365).days.ago
}}

user.tasks.create(tks)

p "Created #{Task.count} task(s)"
