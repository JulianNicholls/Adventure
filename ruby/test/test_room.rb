require 'minitest/autorun'
require 'minitest/pride'

require './room'

describe Room do
  let(:room) { Room.new 'You are standing in a great glass lift' }

  describe '#initialize' do
    it 'should require description only' do
      Room.new('You are standing in a vast stone cavern')
    end

    it 'should accept a monster as well' do
      Room.new(
        'You are standing in a vast stone cavern.',
        Monster.new('Balrog', 3))
    end

    it 'should accept a monster and other items' do
      Room.new(
        'You are standing in a vast stone cavern.',
        Monster.new('Balrog', 3),
        'blue key')

      Room.new(
        'You are standing in a vast stone cavern.',
        Monster.new('Balrog', 3),
        'blue key', 'red jacket')
    end
  end

  describe '#drop' do
    it 'should allow an item to be dropped in the room' do
      room.drop('Copy of Playtroll')
    end
  end

  describe '#description' do
    it 'should describe the room' do
      room.description.must_match(/great glass lift/)
      room.description.wont_match(/You can see/)
      room.description.wont_match(/There's/)
    end

    it 'should describe the room and any items in it' do
      room.drop 'Erumpent Horn'
      room.description.must_match(/great glass lift/)
      room.description.must_match(/You can see/)
      room.description.must_match(/Erumpent Horn/)
      room.description.wont_match(/There's/)
    end

    it 'should describe the room, items, and monster' do
      room2 = Room.new(
        'You are standing in a vast stone cavern.',
        Monster.new('Balrog', 3),
        'blue key', 'red jacket')

      room2.description.must_match(/vast stone cavern/)
      room2.description.must_match(/You can see/)
      room2.description.must_match(/Blue Key and a Red Jacket/)
      room2.description.must_match(/There's/)
      room2.description.must_match(/Balrog/)
    end

    it 'should return the description as its string representation' do
      room.description.must_match room.to_s
    end
  end
end
