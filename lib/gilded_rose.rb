require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update
    update_quality
    update_sell_in
  end

  def update_sell_in
    @items.each { |item| item.sell_in -= 1 if item.name != "Sulfuras, Hand of Ragnaros"}
  end

  def update_quality_brie(item)
    if item.quality < 50
      item.sell_in >= 0 ? item.quality += 1 : item.quality += 2
    end
  end

  def update_quality_backstage(item)
    if item.sell_in > 10 then item.quality += 1
    elsif item.sell_in > 5 then item.quality += 2
    elsif item.sell_in > 0 then item.quality += 3
    else item.quality = 0
    end
    item.quality = 50 if item.quality >= 50
  end

  def update_quality_sulfuras(item)

  end

  def update_quality_conjured(item)
    unless item.quality == 0
      item.sell_in >= 0 ? item.quality -= 2 : item.quality -= 4
    end
  end

  def update_quality_regular(item)
    unless item.quality == 0
      item.sell_in >= 0 ? item.quality -= 1 : item.quality -= 2
    end
  end

  def update_quality
    @items.each do |item|
      case item.name
        when "Aged Brie"
          update_quality_brie(item)
        when "Sulfuras, Hand of Ragnaros"
          update_quality_sulfuras(item)
        when "Backstage passes to a TAFKAL80ETC concert"
          update_quality_backstage(item)
        when "Conjured"
          update_quality_conjured(item)
        else
          update_quality_regular(item)
        end
      end
    end
end
