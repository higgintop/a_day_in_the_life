Fabricator(:journal) do
  user(fabricator: :user)
  title     { Faker::Name }
end
