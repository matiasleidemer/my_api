class Article < ActiveRecord::Base
  validates :title, :body, presence: true

  def published?
    published_at.present?
  end
end
