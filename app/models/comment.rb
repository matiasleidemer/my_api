class Comment < ActiveRecord::Base
  belongs_to :article

  validates :author, :body, :article, presence: true
end
