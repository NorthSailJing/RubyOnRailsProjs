User.destroy_all

user = User.create(
  email: "jing@northsail.io",
  password: "wjl113"
)

p "Created #{User.count} user(s)"

user.tasks.create([
  {
    title: "Ruby on Rails 6.0 Challenge",
    body: "Build a task demo using Rails Ruby on Rails 6.0. And check how to use devise for the authentication.",
    client: "NorthSail",
    duration: 20,
    status: 1
  },
  {
    title: "Create a new admin account in Sitecore CMS on Dev and Stg",
    body: "Create a new admin account in Sitecore CMS on Dev and Stg so that the user can do most maintenance jobs.",
    client: "Molson",
    duration: 6,
    status: 0
  },
  {
    title: "LG Data Transfer Documentation",
    body: "Write a document to specify how to implement the LG Data Transfer manually and setup the task to make it execute automatically",
    client: "Merge",
    duration: 15,
    status: 0
  }
])

p "Created #{Task.count} task(s)"
