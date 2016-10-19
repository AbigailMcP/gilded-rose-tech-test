require_relative 'general_item'

class Conjured  < GeneralItem

  private

  def update_quality
    unless item.quality == 0
      item.sell_in >= 0 ? item.quality -= 2 : item.quality -= 4
    end
  end

  def update_sell_in
    item.sell_in -= 1
  end

end
