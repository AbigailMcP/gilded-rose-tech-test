class Backstage

  def initialize
    @item = item
  end

  def update_quality
    if item.sell_in > 10 then item.quality += 1
    elsif item.sell_in > 5 then item.quality += 2
    elsif item.sell_in > 0 then item.quality += 3
    else item.quality = 0
    end
    item.quality = 50 if item.quality >= 50
  end

end
