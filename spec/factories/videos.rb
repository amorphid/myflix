FactoryGirl.define do
  sequence(:video_title) {|n| "Cool Video \##{n}"}

  factory :video do
    title { generate(:video_title) }
    description Faker::Lorem.paragraphs(1).shuffle.join
    small_cover_url "/small/cover/url"
    large_cover_url "/large/cover/url"
  end
end
