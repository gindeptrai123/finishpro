User.create!(user_name: "huydz",
             email: "huy@gmal.com",
             password: "123456",
             password_confirmation: "123456",
             full_name: "Quang Huy",
             role: 0,
             gender: true)
User.create!(user_name: "renk",
             email: "nguyen@gmal.com",
             password: "123123",
             password_confirmation: "123123",
             full_name: "Hoang Nguyen",
             role: 0,
             gender: true)
User.create!(user_name: "user",
             email: "tuser@gmal.com",
             password: "123123",
             password_confirmation: "123123",
             full_name: "Testing User",
             role: "user",
             gender: true)
Category.create!(name: "news")
Category.create!(name: "food")
Category.create!(name: "place")
16.times do |n|
  title = Faker::WorldCup.team
  description = Faker::Lorem.sentence(word_count: 5)
  content = Faker::Quote.matz
  price = Faker::Number.within(range: 1..1000)
  Tour.create!(title: title,
               description: description,
               content: content,
               image: File.open(File.join(Rails.root, "app/assets/images/halong.jpg")),
               price: price,
               date_in: Date.new(2019,10,31),
               date_out: Date.new(2019,11,01))
end
