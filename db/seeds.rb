User.create! username: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             avatar: "",
             password_confirmation: "foobar",
             role: 1
49.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! username: name,
               email: email,
               avatar: "",
               password: password,
               password_confirmation: password,
               role: 0
end
