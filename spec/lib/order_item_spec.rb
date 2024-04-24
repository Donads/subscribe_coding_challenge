# frozen_string_literal: true

require 'order_item'

RSpec.describe OrderItem do
  describe '.parse_item' do
    subject { described_class.parse_item(order_item) }

    let(:item) { Item.new(description: 'bottle of perfume', category: 'cosmetics') }

    before do
      allow(Item).to receive(:find).with('bottle of perfume').and_return(item)
    end

    context 'when order item is imported' do
      let(:order_item) { '2 imported bottle of perfume at 27.99' }

      it 'returns an imported order item' do
        expect(subject).to have_attributes(item: item, quantity: 2, price: 27.99, imported: true)
      end
    end

    context 'when order item is not imported' do
      let(:order_item) { '3 bottle of perfume at 18.99' }

      it 'returns a non-imported order item' do
        expect(subject).to have_attributes(item: item, quantity: 3, price: 18.99, imported: false)
      end
    end
  end

  describe '#sales_tax' do
    subject { described_class.new(item: item, quantity: 2, price: 14.99, imported: imported).sales_tax }

    context 'when item is exempt from taxes' do
      let(:item) { Item.new(description: 'chocolate bar', category: 'food') }

      context 'and it is imported' do
        let(:imported) { true }

        it 'returns the proper sales tax' do
          expect(subject).to eq(1.50)
        end
      end

      context 'and it is not imported' do
        let(:imported) { false }

        it 'returns the proper sales tax' do
          expect(subject).to eq(0)
        end
      end
    end

    context 'when item is not exempt from taxes' do
      let(:item) { Item.new(description: 'bottle of perfume', category: 'cosmetics') }

      context 'and it is imported' do
        let(:imported) { true }

        it 'returns the proper sales tax' do
          expect(subject).to eq(4.50)
        end
      end

      context 'and it is not imported' do
        let(:imported) { false }

        it 'returns the proper sales tax' do
          expect(subject).to eq(3.0)
        end
      end
    end
  end

  describe '#total' do
    subject { described_class.new(item: item, quantity: 2, price: 10.00, imported: imported).total }

    context 'when item is exempt from taxes' do
      let(:item) { Item.new(description: 'chocolate bar', category: 'food') }

      context 'and it is imported' do
        let(:imported) { true }

        it 'returns the total price for the order item' do
          expect(subject).to eq(21.00)
        end
      end

      context 'and it is not imported' do
        let(:imported) { false }

        it 'returns the total price for the order item' do
          expect(subject).to eq(20.00)
        end
      end
    end

    context 'when item is not exempt from taxes' do
      let(:item) { Item.new(description: 'bottle of perfume', category: 'cosmetics') }

      context 'and it is imported' do
        let(:imported) { true }

        it 'returns the total price for the order item' do
          expect(subject).to eq(23.00)
        end
      end

      context 'and it is not imported' do
        let(:imported) { false }

        it 'returns the total price for the order item' do
          expect(subject).to eq(22.00)
        end
      end
    end
  end

  describe '#decorate_item' do
    subject { described_class.new(item: item, quantity: 2, price: 20.00, imported: imported).decorate_item }

    let(:item) { Item.new(description: 'chocolate bar', category: 'food') }

    context 'when item is imported' do
      let(:imported) { true }

      it 'returns the decorated order item' do
        expect(subject).to eq('2 imported chocolate bar: 42.00')
      end
    end

    context 'when item is not imported' do
      let(:imported) { false }

      it 'returns the decorated order item' do
        expect(subject).to eq('2 chocolate bar: 40.00')
      end
    end
  end
end
