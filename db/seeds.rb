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