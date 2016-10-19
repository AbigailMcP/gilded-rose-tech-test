require_relative 'general_item'

class AgedBrie < GeneralItem

  private

  def update_quality
    if item.quality < 50
      item.sell_in >= 0 ? item.quality += 1 : item.quality += 2
    end
  end

  def update_sell_in
    item.sell_in -= 1
  end

end
