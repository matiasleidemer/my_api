require 'rails_helper'
require 'cancan/matchers'

describe 'Article permissions' do
  subject(:ability) { Ability.new(user) }
  let(:user) { nil }

  context 'Admin' do
    let(:user) { User.new(email: 'foo@bar.com', password: '123change', admin: true) }

    it 'can manage all articles' do
      expect(subject).to be_able_to(:manage, Article.new)
    end
  end

  context 'User' do
    let(:user) { User.create(email: 'foo@bar.com', password: '123change') }

    it 'can read all articles' do
      expect(subject).to be_able_to(:read, Article.new)
    end

    it "can manage it's own articles" do
      expect(subject).to be_able_to(:manage, Article.new(user_id: user.id))
    end
  end

  context 'Guest' do
    let(:user) { User.new }

    it 'can read all articles' do
      expect(subject).to be_able_to(:read, Article.new)
    end
  end
end
