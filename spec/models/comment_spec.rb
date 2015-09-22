require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new }

  context 'validations' do
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:article) }
  end
end
