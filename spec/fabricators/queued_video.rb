Fabricator(:queued_video) do
  priority { sequence(:priority, 1)                         }
  user    { User.count == 0 ? Fabricate(:user) : User.last }
  video   { Fabricate(:video)                              }
end
