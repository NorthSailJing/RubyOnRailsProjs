FactoryBot.define do

  factory :user do
    email {"jing@northsail.io"}
    password {"wjl113"}
  end

  factory :task do
    title {"Ruby on Rails 6.0 Challenge"}
    body {"Build a task demo using Rails Ruby on Rails 6.0. And check how to use devise for the authentication."}
    client {"NorthSail"}
    duration {20}
    status {1}
    user
  end

end
