FactoryGirl.define do
  sequence(:title) {|n| "Cool Video \##{n}"}

  factory :video do
    title { generate(:title) }
    description Faker::Lorem.paragraphs(1).shuffle.join
    small_cover_url "/small/cover/url"
    large_cover_url "/large/cover/url"
  end
end
