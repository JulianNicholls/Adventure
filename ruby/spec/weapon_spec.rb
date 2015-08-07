require 'minitest/autorun'

require './weapon'

describe Weapon do
  let( :sword )       { Weapon.new( 'sword', 2 ) }
  let( :magic_sword ) { Weapon.new( 'magic sword', 3 ) }

  describe '#name' do
    it 'should return its name Capitalised' do
      sword.name.must_equal 'Sword'
      magic_sword.name.must_equal 'Magic Sword'
    end
  end

  describe '#power' do
    it 'should return its power' do
      sword.power.must_equal 2
      magic_sword.power.must_equal 3
    end
  end

  describe '#indefinite_name' do
    it "should return 'a Sword' for the first weapon" do
      sword.indefinite_name.must_equal 'a Sword'
    end

    it "should return 'a Magic Sword' for the second weapon" do
      magic_sword.indefinite_name.must_equal 'a Magic Sword'
    end

    it "should return 'an Iceaxe' for an iceaxe" do
      Weapon.new( 'iceaxe', 2 ).indefinite_name.must_equal 'an Iceaxe'
    end
  end

  describe '#load' do
    let( :wea2 ) { Weapon.load( 'sharpened banana 3' ) }
    let( :wea3 ) { Weapon.load( 'stolen bicorn horn 17' ) }

    it 'should be named correctly' do
      wea2.name.must_equal 'Sharpened Banana'
      wea3.name.must_equal 'Stolen Bicorn Horn'
    end

    it 'should be specified correctly' do
      wea2.indefinite_name.must_equal 'a Sharpened Banana'
      wea3.indefinite_name.must_equal 'a Stolen Bicorn Horn'
    end

    it 'should have the right amount of power' do
      wea2.power.must_equal 3
      wea3.power.must_equal 17
    end
  end
end
