FactoryGirl.define do
  sequence(:category_title) {|n| "Fancy Category \##{n}"}

  factory :category do
    title { generate(:category_title) }

    factory :category_with_videos do
      videos Video.all
    end
  end
end
