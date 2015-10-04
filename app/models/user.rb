class User < ActiveRecord::Base
  has_secure_password

  has_many :articles

  def self.authenticate(email, password)
    return false unless user = find_by_email(email)
    user.authenticate(password)
  end

  def guest?
    new_record?
  end
end
