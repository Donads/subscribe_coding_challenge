# frozen_string_literal: true

require 'item'

RSpec.describe Item do
  describe '.all' do
    subject { described_class.all }

    it 'returns all items' do
      expect(subject.size).to eq(6)
    end
  end

  describe '.find' do
    subject { described_class.find(item_description) }

    context 'when item exists' do
      let(:item_description) { 'music CD' }

      it 'returns the item with the given description' do
        expect(subject).to have_attributes(description: item_description, category: 'music')
      end
    end

    context 'when item does not exist' do
      let(:item_description) { 'random item' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#tax_exempt?' do
    subject { described_class.new(description: 'random item', category: category).tax_exempt? }

    context 'when item is exempt from taxes' do
      let(:category) { 'books' }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when item is not exempt from taxes' do
      let(:category) { 'music' }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end
end
