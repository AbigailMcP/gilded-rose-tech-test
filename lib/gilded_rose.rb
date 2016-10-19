require_relative 'item'
require_relative 'aged_brie'
require_relative 'backstage'
require_relative 'sulfuras'
require_relative 'conjured'
require_relative 'regular_item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update
    @items.each { |item| item_of_type(item).update }
  end

  def update_quality_regular(item)
    unless item.quality == 0
      item.sell_in >= 0 ? item.quality -= 1 : item.quality -= 2
    end
  end

  private

  attr_reader :item

  ITEMS = { "Aged Brie" => AgedBrie, "Sulfuras, Hand of Ragnaros" => Sulfuras,
            "Backstage passes to a TAFKAL80ETC concert" => Backstage, "Conjured" => Conjured
          }.freeze

  def special_item?(item)
    ITEMS.include?(item.name)
  end

  def item_of_type(item)
    special_item?(item) ? ITEMS[item.name].new(item) : RegularItem.new(item)
  end
end
