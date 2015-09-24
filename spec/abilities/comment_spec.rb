require 'rails_helper'
require 'cancan/matchers'

describe 'Comment permissions' do
  subject(:ability) { Ability.new(user) }
  let(:user) { nil }

  context 'Admin' do
    let(:user) { User.new(email: 'foo@bar.com', password: '123change', admin: true) }

    it 'can manage all comments' do
      expect(subject).to be_able_to(:manage, Comment.new)
    end
  end

  context 'User' do
    let(:user) { User.create(email: 'foo@bar.com', password: '123change') }

    it 'can read all comments' do
      expect(subject).to be_able_to(:read, Comment.new)
    end

    it 'can create new comments' do
      expect(subject).to be_able_to(:create, Comment.new)
    end
  end

  context 'Guest' do
    let(:user) { User.new }

    it 'can read all comments' do
      expect(subject).to be_able_to(:read, Comment.new)
    end

    it 'can create new comments' do
      expect(subject).to be_able_to(:create, Comment.new)
    end
  end
end
