# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "Admin",
  email: "admin@framgia.com",
  password: "password",
  password_confirmation: "password",
  is_admin: true
)

30.times do |n|
  name  = "User #{n+1}"
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
following = users[2..20]
followers = users[3..20]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

category = Category.order(:name).first
8.times do |n|
  category = Category.create(name: "Category #{n+1}")
  20.times do |m|
    category.words.create(
      content: "Word #{n+1} #{m+1}",
      word_answers_attributes: [
        {content: "answers 1", is_correct: true},
        {content: "answers 2", is_correct: false},
        {content: "answers 3", is_correct: false},
        {content: "answers 4", is_correct: false},
        {content: "answers 5", is_correct: false}
      ]
    )
  end
end
