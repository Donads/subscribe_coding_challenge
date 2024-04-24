# frozen_string_literal: true

class Order
  def initialize(order_file:)
    @order_file = order_file
  end

  def print_receipt
    print_order_items
    print_sales_tax
    print_total
  end

  private

  def order_items
    @order_items ||= File.read(@order_file).split("\n").map do |order_item|
      OrderItem.parse_item(order_item)
    end
  end

  def order_total_with_tax
    order_items.sum(&:total)
  end

  def sales_tax
    order_items.sum(&:sales_tax)
  end

  def print_order_items
    order_items.each do |order_item|
      puts order_item.decorate_item
    end
  end

  def print_sales_tax
    puts "Sales Taxes: #{format_number(sales_tax)}"
  end

  def print_total
    puts "Total: #{format_number(order_total_with_tax)}"
  end

  def format_number(number)
    format('%.2f', number)
  end
end
