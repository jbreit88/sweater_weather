class UserSerializer

  def self.format_user(user)

    {
      data: {
        id: user.id,
        type: 'users',
        attributes: {
          email: user.email,
          api_keys: user.api_keys.map do |key|
            key.token
          end
        }
      }
    }
  end
end
