require 'rails_helper'

describe Authenticator do
  describe '#authenticate' do
    let(:repository) { double(:user) }

    let(:subject) do
      described_class.new('foo@bar.com', '123change', repository: repository)
    end

    context 'with valid credentials' do
      before { allow(subject).to receive(:guest?).and_return false }

      it 'authenticates the user' do
        expect(repository).to receive(:authenticate).with('foo@bar.com', '123change')
        subject.authenticate
      end
    end

    context 'with guest credentials' do
      before { allow(subject).to receive(:guest?).and_return true }

      it 'returns a guest user' do
        expect(repository).to receive(:new)
        subject.authenticate
      end
    end
  end

  describe '#guest?' do
    context 'with guest credentials' do
      let(:subject) { described_class.new('guest', 'guest') }

      it 'returns true' do
        expect(subject.guest?).to be true
      end
    end

    context 'without guest credentials' do
      let(:subject) { described_class.new('foo', 'bar') }

      it 'returns false' do
        expect(subject.guest?).to be false
      end
    end
  end
end

