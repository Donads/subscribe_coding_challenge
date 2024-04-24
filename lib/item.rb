# frozen_string_literal: true

require 'json'

class Item
  attr_reader :description, :category

  TAX_EXEMPT_CATEGORIES = %w[books food medical].freeze

  def initialize(description:, category:)
    @description = description
    @category = category
  end

  def self.all
    @all ||= JSON.parse(File.read('support/items.json')).map do |item|
      Item.new(description: item['description'], category: item['category'])
    end
  end

  def self.find(description)
    all.find { |item| item.description == description }
  end

  def tax_exempt?
    TAX_EXEMPT_CATEGORIES.include?(category)
  end
end
