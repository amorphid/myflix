Fabricator(:review) do
  description { Faker::Lorem.paragraphs(5).join(" ")           }
  rating      { rand(1..5)                                     }
  user        { User.count == 0 ? Fabricate(:user) : User.last }
  video       { Fabricate(:video)                              }
end
