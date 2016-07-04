# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "Hoang Thi Lanh",
  email: "lanh@lanh.lanh",
  password: "lanhde",
  password_confirmation: "lanhde",
  is_admin: true
)

User.create(name: "Do Gia Dat",
  email: "dat@dat.dat",
  password: "datdat",
  password_confirmation: "datdat"
)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password
    )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

10.times do |n|
  Category.create(name: "Category #{n}")
end

category = Category.order(:name).first
20.times do |n|
  content = "Word #{n}"
  category.words.create(
    content: content,
    word_answers_attributes: [
      {content: "answers 1", is_correct: true},
      {content: "answers 2", is_correct: false},
      {content: "answers 3", is_correct: false},
      {content: "answers 4", is_correct: false},
      {content: "answers 5", is_correct: false}
    ]
  )
end
