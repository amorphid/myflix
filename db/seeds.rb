# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([
  { title: "New Release" },
  { title: "Comedy" },
  { title: "Drama" },
  { title: "Science Fiction" }
])

videos = Video.create([
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/30-rock-small.jpg",
    large_cover_url: "/tmp/30-rock-large.jpg"
  },
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/battlestar-galactica-small.jpg",
    large_cover_url: "/tmp/battlestar-galactica-large.jpg"
  },
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/power-rangers-in-space-small.jpg",
    large_cover_url: "/tmp/power-rangers-in-space-large.jpg"
  },
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/stargate-atlantis-small.jpg",
    large_cover_url: "/tmp/stargate-atlantis-large.jpg"
  },
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/stargate-sg1-small.jpg",
    large_cover_url: "/tmp/stargate-sg1-large.jpg"
  },
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/storage-wars-small.jpg",
    large_cover_url: "/tmp/storage-wars-large.jpg"
  },
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/the-killing-small.jpg",
    large_cover_url: "/tmp/the-killing-large.jpg"
  },
  {
    title: Faker::Lorem.words(rand(1..4)).join(" "),
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/the-walking-dead-small.jpg",
    large_cover_url: "/tmp/the-walking-dead-large.jpg"
  }
])

# Requires videos and categories
Video.all.each do |video|
  categories = Category.all.shuffle

  (rand(3) + 1).times do
    VideoCategory.create(category_id: categories.pop.id, video_id: video.id)
  end
end
