json.array!(@users) do |user|
  json.extract! user, :id, :name, :role_id, :password_digest
  json.url user_url(user, format: :json)
end
