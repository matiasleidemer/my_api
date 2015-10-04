require 'rails_helper'

describe User do
  describe '.authenticate' do
    let!(:user) { create(:user) }

    context 'with valid credentials' do
      it 'returns the user' do
        expect(User.authenticate('foo@bar.com', '123change')).to eq user
      end
    end

    context 'without valid credentials' do
      it 'returns false' do
        expect(User.authenticate('not@domain.com', 'wat')).to eq false
      end
    end
  end
end

