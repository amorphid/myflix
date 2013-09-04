# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = Movie.create(
  [
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
      title: "Power Rangers In Space",
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
  ]
)
