Fabricator(:user) do
  full_name { Faker::Name.name      }
  email     { Faker::Internet.email }

  password = Faker::Internet.password
  password              { password }
  password_confirmation { password }

  password_reset_token { SecureRandom.urlsafe_base64 }
  small_pic_url "/tmp/user-small.jpg"
end
