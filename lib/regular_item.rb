class RegularItem

  def initialize
    @item = item
  end

  def update_quality
    unless item.quality == 0
      item.sell_in >= 0 ? item.quality -= 1 : item.quality -= 2
    end
  end

end
