# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([
  { title: "Action" },
  { title: "Comedy" },
  { title: "Drama" },
  { title: "Kids" },
  { title: "Science Fiction"}
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
    password_confirmation: "la",
    small_pic_url: "/tmp/jorge-muffin-fluffer-small.jpg"
  },
  {
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "la",
    password_confirmation: "la",
    small_pic_url: "/tmp/user-small.jpg"
  },
  {
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "la",
    password_confirmation: "la",
    small_pic_url: "/tmp/user-small.jpg"
  }
])

# randomly assign movies to catgories
categories.each do |category|
  videos.each do |video|
    coin_flip = rand(2)
    if coin_flip == 1 then
      VideoCategory.create(category_id: category.id, video_id: video.id)
    end
  end
end

# All videos category (has all videos!)
all_videos_cat = Category.create(title: "All Videos")
all_videos_cat.videos << videos

# One movie have no reviews
# All other movies have one review per user
videos[0..-2].each do |video|
  users.each do |user|
    Review.create(description: Faker::Lorem.paragraph(10),
                  rating:      rand(1..5),
                  user_id:     user.id,
                  video_id:    video.id)
  end
end

# One video is not associated with a queued video
# All other videos have one queued_video per User
videos[0..-2].each do |video|
  users.each do |user|
    QueuedVideo.create(
      priority: video.id, user_id: user.id, video_id: video.id)
  end
end

# each follower is following all users
users.each do |user|
  Follower.create(user_id: user.id)
  user.follower.users << users
end
