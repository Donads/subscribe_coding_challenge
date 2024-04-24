# frozen_string_literal: true

require 'order'

RSpec.describe Order do
  describe '#print_receipt' do
    subject { described_class.new(order_file: 'spec/fixtures/order_example') }

    it 'prints the receipt' do
      expect { subject.print_receipt }.to output(
        <<~RECEIPT
          1 imported bottle of perfume: 32.19
          1 bottle of perfume: 20.89
          1 packet of headache pills: 9.75
          3 imported box of chocolates: 35.55
          Sales Taxes: 7.90
          Total: 98.38
        RECEIPT
      ).to_stdout
    end
  end
end
