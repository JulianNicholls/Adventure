require 'minitest/autorun'
require 'minitest/pride'

require './inventory'

# Allow access to the items
class Inventory
  attr_reader :items
end

describe Inventory do
  let( :blade ) { Weapon.new( 'Vorpal Blade', 3 ) }

  describe '#initialize' do
    it 'should allow for initializing empty' do
      inv = Inventory.new
      inv.items.size.must_equal 0
    end

    it 'should allow for initializing with a string item' do
      inv = Inventory.new( 'Blue key' )
      inv.items.size.must_equal 1
      inv.items[0].must_equal 'Blue Key'
    end

    it 'should allow for initializing with an Item' do
      inv = Inventory.new( blade )
      inv.items.size.must_equal 1
      inv.items[0].name.must_equal 'Vorpal Blade'
    end

    it 'should allow for initializing with an array of string items' do
      inv = Inventory.new( *['blue key', 'green parrot'] )
      inv.items.size.must_equal 2
      inv.items[0].must_equal 'Blue Key'
      inv.items[1].must_equal 'Green Parrot'
    end

    it 'should allow for initializing with an arrayed mix of items' do
      inv = Inventory.new( *['blue key', blade, 'green parrot'] )
      inv.items.size.must_equal 3
      inv.items[0].must_equal 'Blue Key'
      inv.items[1].name.must_equal 'Vorpal Blade'
      inv.items[2].must_equal 'Green Parrot'
    end

    it 'should allow for initializing with a listed mix of items' do
      inv = Inventory.new( 'blue key', blade, 'green parrot' )
      inv.items.size.must_equal 3
      inv.items[0].must_equal 'Blue Key'
      inv.items[1].name.must_equal 'Vorpal Blade'
      inv.items[2].must_equal 'Green Parrot'
    end
  end

  describe '#size' do
    it 'should return the correct number of items' do
      inv0 = Inventory.new
      inv0.size.must_equal 0

      inv1 = Inventory.new( 'Blue key' )
      inv1.size.must_equal 1

      inv2 = Inventory.new( *['blue key', 'green parrot'] )
      inv2.size.must_equal 2

      inv3 = Inventory.new( 'blue key', blade, 'green parrot' )
      inv3.size.must_equal 3
    end
  end

  describe "#contents, with capitalisation, commas and 'and's" do
    it 'should return one item correctly' do
      inv = Inventory.new( 'blue key' )
      inv.contents.must_equal 'A Blue Key'
    end

    it 'should return two items correctly' do
      inv = Inventory.new( 'blue key', 'green parrot' )
      inv.contents.must_equal 'A Blue Key and a Green Parrot'
    end

    it 'should return three items correctly' do
      inv = Inventory.new( 'blue key', blade, 'red wallet' )
      inv.contents.must_equal 'A Blue Key, a Vorpal Blade and a Red Wallet'
    end
  end

  describe '#got_a etc' do
    let( :armed )   { Inventory.new( 'Cursed Sword', 'Rendered Kneecap' ) }
    let( :keyedup ) { Inventory.new( 'Blue Key', 'Boiled Head' ) }
    let( :wanting ) do
      Inventory.new( 'Baboon Bottom', 'Mystical Cube', 'Rubber Hammer' )
    end

    it 'should return whether there is a key correctly' do
      armed.got_a_key?.must_equal false
      keyedup.got_a_key?.must_equal true
      wanting.got_a_key?.must_equal false
    end

    it 'should return whether there is a sword correctly' do
      armed.got_a_sword?.must_equal true
      keyedup.got_a_sword?.must_equal false
      wanting.got_a_sword?.must_equal false
    end

    it 'should return whether there is a cube correctly' do
      armed.got_a?( 'cube' ).must_equal false
      keyedup.got_a?( 'cube' ).must_equal false
      wanting.got_a?( 'cube' ).must_equal true
    end
  end

  describe '#add' do
    let( :useless ) { Inventory.new( 'Wavy flagpole', 'ironed Prune' ) }

    it 'should be possible to add a single item' do
      useless.add( 'Aardvark Snout' )
      useless.items.size.must_equal 3
    end

    it 'should be possible to add an array of items' do
      useless.add( *['Aardvark Snout', 'Zebra Suit'] )
      useless.items.size.must_equal 4
    end

    it 'should be possible to add a number of items' do
      useless.add( *['Aardvark Snout', 'Zebra Suit', 'Mouse Squeak'] )
      useless.items.size.must_equal 5
    end
  end

  describe '#drop' do
    let( :loaded )  { Inventory.new( 'Blue Key', 'Cursed Sword', 'Boiled Head' ) }

    it 'should allow an item to be dropped, and return it' do
      loaded.drop( 'sword' ).must_equal 'Cursed Sword'
      loaded.items.size.must_equal 2
      loaded.contents.must_equal 'A Blue Key and a Boiled Head'
    end
  end
end
