require_relative 'general_item'

class RegularItem  < GeneralItem

  private

  def update_quality
    item.sell_in >= 0 ? item.quality -= 1 : item.quality -= 2
    item.quality = 0 if item.quality < 0
  end

  def update_sell_in
    item.sell_in -= 1
  end

end
