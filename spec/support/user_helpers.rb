def create_user(opts = {})
  default_opts = {email: 'test@example.com', password: '12345678'}
  User.create!(default_opts.merge(opts))
end

def create_organization(opts = {})
  default_opts = {
    :legally_formed => false,
    :email => "Email",
    :telephone_number => "Telephone Number",
    :name => SecureRandom.uuid,
    :twitter => "Twitter",
    :facebook => "Facebook"
  }
  Organization.create!(default_opts.merge(opts))
end
