User.create!(
  name: "Admin User",
  email: "adminuser@email.com",
  password: "adminuser",
  password_confirmation: "adminuser",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)


20.times do |n|
  User.create!(
    name: "defaultuser#{n + 1}",
    email: "defaultuser#{n + 1}@email.com",
    password: "adminuser",
    password_confirmation: "adminuser"
  )
end

users = User.order(:created_at).take(6)
20.times do
  users.each { |user| user.posts.create!(content: 'content') }
end

users = User.all
user  = users.first
following = users[2..5]
followers = users[3..4]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }