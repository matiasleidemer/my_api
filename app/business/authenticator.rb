class Authenticator
  def initialize(email, password, opts = {})
    @email      = email
    @password   = password
    @repository = opts.fetch(:repository, default_repository)
  end

  def self.call(email, password, opts = {})
    new(email, password, opts).authenticate
  end

  def authenticate
    if guest?
      repository.new
    else
      repository.authenticate(email, password)
    end
  end

  def guest?
    email == 'guest' && password == 'guest'
  end

  private

  attr_reader :email, :password, :repository

  def default_repository
    User
  end
end
