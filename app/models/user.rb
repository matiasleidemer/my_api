class User < ActiveRecord::Base
  acts_as_token_authenticatable

  has_many :articles
end
