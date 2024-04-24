# frozen_string_literal: true

require_relative 'lib/item'
require_relative 'lib/order_item'
require_relative 'lib/order'

class App
  def initialize; end

  def process_orders
    order_files.map do |order_file|
      order = Order.new(order_file: "orders/#{order_file}")

      puts "\nReceipt for #{order_file}:"
      order.print_receipt
    end
  end

  private

  def order_files
    Dir.children('orders').sort
  end
end

App.new.process_orders
