admin = User.create!(email: 'admin@trycatch.us', password: '123change', password_confirmation: '123change')
user  = User.create!(email: 'user@trycatch.us' , password: 'change123', password_confirmation: 'change123')

4.times do
  article = Article.create!(
    title: Faker::Hacker.say_something_smart,
    body: Faker::Lorem.paragraph(7),
    author: [admin, user].sample
  )

  5.times do
   Comment.create!(
      author: Faker::Name.name,
      body: Faker::Lorem.paragraph(7),
      article: article
    )
  end
end
