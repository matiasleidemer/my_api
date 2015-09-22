require 'rails_helper'

describe Article do
  subject { Article.new }

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:author) }
  end

  describe '#published?' do
    context 'when published_at is present' do
      before { subject.published_at = Time.now }

      it 'returns true' do
        expect(subject.published?).to be true
      end
    end

    context 'when published_at is empty' do
      before { subject.published_at = nil }

      it 'returns false' do
        expect(subject.published?).to be false
      end
    end
  end
end
