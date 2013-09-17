Fabricator(:queued_video) do
  priority { sequence(:priority, 1) }
end
