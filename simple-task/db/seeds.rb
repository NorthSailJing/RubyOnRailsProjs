require 'faker'

User.destroy_all

user = User.create(
  email: "jing@northsail.io",
  password: "wjl113"
)

p "Created #{User.count} user(s)"

tks = []
1000.times {
tks << {
  title: Faker::Lorem.words(rand(3..10)).join(' '), 
  body: Faker::Lorem.paragraph(sentence_count: rand(1..3)),
  client: ["NorthSail", "Molson", "Merge"].sample,
  duration: rand(1..100),
  status: rand(0..1),
  entered_on: rand(1..365).days.ago
}}

user.tasks.create(tks)

p "Created #{Task.count} task(s)"
