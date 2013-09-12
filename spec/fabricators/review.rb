Fabricator(:review) do
  description { Faker::Lorem.paragraphs(5).join(" ") }
  rating      { rand(1..5) }
end
