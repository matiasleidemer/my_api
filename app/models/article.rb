class Article < ActiveRecord::Base
  belongs_to :author, class_name: User, foreign_key: :user_id
  has_many :comments

  validates :title, :body, :author, presence: true

  def published?
    published_at.present?
  end
end
