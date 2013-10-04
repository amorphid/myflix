Fabricator(:user) do
  full_name { Faker::Name.name      }
  email     { Faker::Internet.email }

  password = Faker::Internet.password
  password              { password }
  password_confirmation { password }

  small_pic_url "/tmp/user-small.jpg"
end
