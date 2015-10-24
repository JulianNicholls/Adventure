require 'minitest/autorun'
require 'minitest/pride'

require './monster'
require './weapon'

describe Monster do
  let( :monster )     { Monster.new( 'balrog', 2 ) }
  let( :big_monster ) { Monster.new( 'dragon', 20 ) }
  let( :sword )       { Weapon.new( 'Sword', 2 ) }

  describe '#health' do
    it 'should return its hitpoints' do
      monster.health.must_equal 2
      big_monster.health.must_equal 20
    end
  end

  describe '#name' do
    it 'should return its name Capitalised' do
      monster.name.must_equal 'Balrog'
      big_monster.name.must_equal 'Dragon'
    end
  end

  describe '#indefinite_name' do
    it "should return 'a Balrog' for the first monster" do
      monster.indefinite_name.must_equal 'a Balrog'
    end

    it "should return 'a Dragon' for the second monster" do
      big_monster.indefinite_name.must_equal 'a Dragon'
    end

    it "should return 'an Orc' for an orc" do
      Monster.new( 'orc', 2 ).indefinite_name.must_equal 'an Orc'
    end
  end

  describe '#hit' do
    it 'should remove 1 hitpoint OK' do
      monster.hit( 1 )
      monster.health.must_equal 1

      big_monster.hit( 1 )
      big_monster.health.must_equal 19
    end

    it 'should remove 2 hitpoints OK' do
      monster.hit( 2 )
      monster.health.must_equal 0

      big_monster.hit( 2 )
      big_monster.health.must_equal 18
    end

    it 'should remove more than the total of hitpoints OK' do
      monster.hit( 3 )
      monster.health.must_equal 0

      big_monster.hit( 35 )
      big_monster.health.must_equal 0
    end

    it 'should understand weapons for hitting' do
      monster.hit( sword )
      monster.health.must_equal 0
    end
  end

  describe '#dead?' do
    it 'should return false if the monster is alive' do
      monster.dead?.must_equal false
      big_monster.dead?.must_equal false
    end

    it 'should return true if the monster is dead' do
      monster.hit( 3 )
      monster.dead?.must_equal true

      big_monster.hit( 35 )
      big_monster.dead?.must_equal true
    end
  end

  describe '#heal' do
    it 'should heal the monster by a point' do
      monster.hit( 1 )
      monster.heal
      monster.health.must_equal 2

      big_monster.hit( 5 )
      big_monster.heal
      big_monster.health.must_equal 16
    end

    it 'should not heal the monster past its maximum' do
      monster.heal
      monster.health.must_equal 2

      big_monster.heal
      big_monster.health.must_equal 20
    end

    it 'should not heal a dead monster' do
      monster.hit( 3 )
      monster.dead?.must_equal true
      monster.heal
      monster.dead?.must_equal true

      big_monster.hit( 35 )
      big_monster.dead?.must_equal true
      big_monster.heal
      big_monster.dead?.must_equal true
    end
  end

  describe '#load' do
    let( :mon2 ) { Monster.load( 'angry gnome 3' ) }
    let( :mon3 ) { Monster.load( 'unnaturally huge leprechaun 17' ) }

    it "should be called 'Angry Gnome'" do
      mon2.name.must_equal 'Angry Gnome'
      mon3.name.must_equal 'Unnaturally Huge Leprechaun'
    end

    it "should be 'an Angry Gnome'" do
      mon2.indefinite_name.must_equal 'an Angry Gnome'
      mon3.indefinite_name.must_equal 'an Unnaturally Huge Leprechaun'
    end

    it 'should have the right number of hit points' do
      mon2.health.must_equal 3
      mon3.health.must_equal 17
    end
  end
end
