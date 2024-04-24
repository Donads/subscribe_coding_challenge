# frozen_string_literal: true

class OrderItem
  attr_reader :item, :quantity, :price, :imported

  BASIC_SALES_TAX = 0.10
  IMPORT_TAX = 0.05

  ITEM_REGEX = /
  \A
    (?<quantity>\d+)
    \s?
    (?<origin>imported|)
    \s
    (?<description>.*)
    \sat\s
    (?<price>\d+(\.\d+)?)
  \Z
  /x.freeze

  def initialize(item:, quantity:, price:, imported:)
    @item = item
    @quantity = quantity
    @price = price
    @imported = imported
  end

  def self.parse_item(item_row)
    item_hash = ITEM_REGEX.match(item_row)
    item = Item.find(item_hash[:description])
    quantity = item_hash[:quantity].to_i
    price = item_hash[:price].to_f
    imported = item_hash[:origin] == 'imported'

    new(item: item, quantity: quantity, price: price, imported: imported)
  end

  def total
    (price + item_tax) * quantity
  end

  def sales_tax
    item_tax * quantity
  end

  def decorate_item
    "#{quantity} #{imported ? 'imported ' : ''}#{item.description}: #{format_number(total)}"
  end

  private

  def item_tax
    round_up_to_nearest_0_05(price * tax_multiplier)
  end

  def round_up_to_nearest_0_05(number)
    (number * 20).ceil / 20.0
  end

  def tax_multiplier
    tax_multiplier = 0
    tax_multiplier += BASIC_SALES_TAX unless item.tax_exempt?
    tax_multiplier += IMPORT_TAX if imported
    tax_multiplier.round(2)
  end

  def format_number(number)
    format('%.2f', number)
  end
end
