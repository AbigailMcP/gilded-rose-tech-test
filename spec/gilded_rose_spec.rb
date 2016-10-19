require 'gilded_rose'

describe GildedRose do

  describe "#update" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update
      expect(items[0].name).to eq "foo"
    end

    it "reduces sell_in by one at the end of the day" do
      items = [Item.new("foo", 1, 0)]
      GildedRose.new(items).update
      expect(items[0].sell_in).to eq 0
    end

    it "sell_in value is allowed to be negative" do
      items = [Item.new("foo", 1, 0)]
      gilded_rose = GildedRose.new(items)
      2.times { gilded_rose.update }
      expect(items[0].sell_in).to eq -1
    end

    it "quality is never negative" do
      items = [Item.new("foo", 1, 0)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end
  end

  context 'when item is a regular item' do
    it 'reduces quality by 1 if sell_in >= 0' do
      items = [Item.new("foo", 1, 1)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end

    it 'reduces quality by 2 if sell_in < 0' do
      items = [Item.new("foo", -1, 2)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end
  end

  context 'when item is Aged Brie' do
    it 'increases quality by 1 if sell_in >= 0' do
      items = [Item.new("Aged Brie", 1, 1)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 2
    end

    it 'increases quality by 2 if sell_in < 0' do
      items = [Item.new("Aged Brie", -1, 1)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 3
    end

    it "maximum quality is 50" do
      items = [Item.new("Aged Brie", 1, 50)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 50
    end
  end

  context 'when item is Sulfuras' do
    it 'never has to be sold' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 1)]
      GildedRose.new(items).update
      expect(items[0].sell_in).to eq 1
    end

    it 'never decreases in quality' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 1)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 1
    end
  end

  context 'when item is Backstage Pass' do
    context 'when sell_in > 10' do
      it 'quality increases by 1' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 1)]
        GildedRose.new(items).update
        expect(items[0].quality).to eq 2
      end

      it 'quality does not exceed 50' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)]
        GildedRose.new(items).update
        expect(items[0].quality).to eq 50
      end
    end

    context 'when sell_in > 5 but <= 10' do
      it 'quality increases by 2' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 1)]
        GildedRose.new(items).update
        expect(items[0].quality).to eq 3
      end

      it 'quality does not exceed 50' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)]
        GildedRose.new(items).update
        expect(items[0].quality).to eq 50
      end
    end

    context 'when sell_in > 0 but <= 5' do
      it 'quality increases by 3' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 1)]
        GildedRose.new(items).update
        expect(items[0].quality).to eq 4
      end

      it 'quality does not exceed 50' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48)]
        GildedRose.new(items).update
        expect(items[0].quality).to eq 50
      end
    end

    context 'when concert has passed' do
      it 'quality drops to 0' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)]
        GildedRose.new(items).update
        expect(items[0].quality).to eq 0
      end
    end
  end

  context 'when item is Conjured' do
    it 'decreases quality by 2 if sell_in >= 0' do
      items = [Item.new("Conjured", 1, 2)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end

    it 'decreases quality by 4 if sell_in >= 0' do
      items = [Item.new("Conjured", -1, 4)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end
  end
end
