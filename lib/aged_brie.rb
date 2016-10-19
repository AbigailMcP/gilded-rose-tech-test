class AgedBrie

  def initialize
    @item = item
  end

  def update_quality
    if item.quality < 50
      item.sell_in >= 0 ? item.quality += 1 : item.quality += 2
    end
  end

end
