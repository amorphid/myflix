# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([
  { title: "Kid Friendly" },
  { title: "Comedy" },
  { title: "Drama" },
  { title: "Science Fiction" }
])

videos = Video.create([
  {
    title: "30 Rock",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/30-rock-small.jpg",
    large_cover_url: "/tmp/30-rock-large.jpg"
  },
  {
    title: "Battlestar Galactica",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/battlestar-galactica-small.jpg",
    large_cover_url: "/tmp/battlestar-galactica-large.jpg"
  },
  {
    title: "Power Ranges In Space",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/power-rangers-in-space-small.jpg",
    large_cover_url: "/tmp/power-rangers-in-space-large.jpg"
  },
  {
    title: "Stargate Atlantis",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/stargate-atlantis-small.jpg",
    large_cover_url: "/tmp/stargate-atlantis-large.jpg"
  },
  {
    title: "Stargate SG1",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/stargate-sg1-small.jpg",
    large_cover_url: "/tmp/stargate-sg1-large.jpg"
  },
  {
    title: "Storage Wars",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/storage-wars-small.jpg",
    large_cover_url: "/tmp/storage-wars-large.jpg"
  },
  {
    title: "The Killing",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/the-killing-small.jpg",
    large_cover_url: "/tmp/the-killing-large.jpg"
  },
  {
    title: "The Walking Dead",
    description: Faker::Lorem.paragraphs(1).join,
    small_cover_url: "/tmp/the-walking-dead-small.jpg",
    large_cover_url: "/tmp/the-walking-dead-large.jpg"
  }
])

users = User.create([
  {
    full_name: "Jorge Muffin Fluffer",
    email: "a@b.c",
    password: "la",
    password_confirmation: "la"
  }
])

# Requires videos and categories
Video.all.each do |video|
  categories = Category.all.shuffle

  (rand(3) + 1).times do
    VideoCategory.create(category_id: categories.pop.id, video_id: video.id)
  end
end

# All videos
FactoryGirl.create(:category_with_videos, title: "All videos")
