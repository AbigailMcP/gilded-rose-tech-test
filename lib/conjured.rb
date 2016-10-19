class Conjured

  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update
    update_quality
    update_sell_in
  end

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
