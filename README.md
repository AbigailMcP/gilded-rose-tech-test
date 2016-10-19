## Ruby solution for Gilded Rose Kata

### The brief

"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city ran by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

All items have a SellIn value which denotes the number of days we have to sell the item
All items have a Quality value which denotes how valuable the item is
At the end of each day our system lowers both values for every item
Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- “Aged Brie” actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
- “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

* “Conjured” items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything still works correctly. However, do not alter the Item class or Items property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t believe in shared code ownership (you can make the UpdateQuality method and Items property static if you like, we’ll cover for you)."*

## Installation instructions

Set up:

    $ git clone https://github.com/AbigailMcP/gilded-rose-tech-test


Run tests:

    $ rspec spec/gilded_rose_spec.rb

## Notes

#### First-stage refactoring

Initially, I began by writing a suite of tests that covered the existing functionality of the original program. I ran the tests after each refactoring step to ensure that the intended functionality had not been altered in any way.

I then pulled out different `update_quality` methods for each type of item, which were called via a case statement - matching item names to the relevant methods.

I also extracted an `update_sell_in` method, which was the same for every item type (expect Sulfuras, in which case the method was never called).

At this stage, functionality was preserved and it was relatively easy to add in a new `update_quailty` method for the new 'Conjured' item type - adding the logic to the case statement to ensure it was called for the correct items.

#### Second-stage refactoring

The second stage of my refactoring process involving extracting the methods for each item type into separate classes, to adhere to the principle of Single Responsibility. Each item class now includes an `update` method, which calls their particular `update_quality` and `update_sell_in` methods.

The Gilded Rose class retains its own `update` method which cycles through each item and chooses the item type (and hence the correct class methods) based on the item's name.
