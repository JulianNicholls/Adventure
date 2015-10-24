require 'minitest/autorun'
require 'minitest/pride'

require './lexicon'

describe Lexicon do
  Pair = Lexicon::Pair

  describe 'directions' do
    it 'should return a direction for each of these' do
      Lexicon.scan( 'north' ).must_equal [Pair.new( :direction, 'north' )]
      Lexicon.scan( 'south' ).must_equal [Pair.new( :direction, 'south' )]
      Lexicon.scan( 'east' ).must_equal [Pair.new( :direction, 'east' )]
      Lexicon.scan( 'west' ).must_equal [Pair.new( :direction, 'west' )]
      Lexicon.scan( 'up' ).must_equal [Pair.new( :direction, 'up' )]
      Lexicon.scan( 'down' ).must_equal [Pair.new( :direction, 'down' )]
      Lexicon.scan( 'left' ).must_equal [Pair.new( :direction, 'left' )]
      Lexicon.scan( 'right' ).must_equal [Pair.new( :direction, 'right' )]
    end

    # This is sufficient for testing that mixed case is handled, it's not necessary
    # to do this for each type

    it 'should return a direction for mixed case directions' do
      Lexicon.scan( 'NORTH' ).must_equal [Pair.new( :direction, 'north' )]
      Lexicon.scan( 'eaST' ).must_equal [Pair.new( :direction, 'east' )]
      Lexicon.scan( 'sOUth' ).must_equal [Pair.new( :direction, 'south' )]
      Lexicon.scan( 'West' ).must_equal [Pair.new( :direction, 'west' )]
    end
  end

  describe 'verbs' do
    it 'should return verb for each of these' do
      Lexicon.scan( 'go' ).must_equal [Pair.new( :verb, 'go' )]
      Lexicon.scan( 'kill' ).must_equal [Pair.new( :verb, 'kill' )]
      Lexicon.scan( 'eat' ).must_equal [Pair.new( :verb, 'eat' )]
      Lexicon.scan( 'dig' ).must_equal [Pair.new( :verb, 'dig' )]
      Lexicon.scan( 'take' ).must_equal [Pair.new( :verb, 'take' )]
      Lexicon.scan( 'drop' ).must_equal [Pair.new( :verb, 'drop' )]
    end

    it 'should return a movement phrase' do
      Lexicon.scan( 'go north' )
        .must_equal [Pair.new( :verb, 'go' ), Pair.new( :direction, 'north' )]
    end
  end

  describe 'stops' do
    it 'should return stop words' do
      Lexicon.scan( 'the' ).must_equal [Pair.new( :stop, 'the' )]
      Lexicon.scan( 'in' ).must_equal [Pair.new( :stop, 'in' )]
      Lexicon.scan( 'of' ).must_equal [Pair.new( :stop, 'of' )]
      Lexicon.scan( 'and' ).must_equal [Pair.new( :stop, 'and' )]
    end

    it 'should try cockney rhyming slang' do
      Lexicon.scan( 'north and south' )
        .must_equal [Pair.new( :direction, 'north' ),
                     Pair.new( :stop, 'and' ),
                     Pair.new( :direction, 'south' )]
    end
  end

  describe 'nouns' do
    it 'should return noun for each of these' do
      Lexicon.scan( 'bear' ).must_equal [Pair.new( :noun, 'bear' )]
      Lexicon.scan( 'princess' ).must_equal [Pair.new( :noun, 'princess' )]
      Lexicon.scan( 'tower' ).must_equal [Pair.new( :noun, 'tower' )]
    end

    it 'should like princesses' do
      Lexicon.scan( 'dig the princess' )
        .must_equal [Pair.new( :verb, 'dig' ),
                     Pair.new( :stop, 'the' ),
                     Pair.new( :noun, 'princess' )]
    end
  end

  describe 'numbers' do
    it 'should recognise numbers' do
      Lexicon.scan( '1' ).must_equal [Pair.new( :number, 1 )]
      Lexicon.scan( '12' ).must_equal [Pair.new( :number, 12 )]
      Lexicon.scan( '123' ).must_equal [Pair.new( :number, 123 )]
      Lexicon.scan( '1234' ).must_equal [Pair.new( :number, 1234 )]
      Lexicon.scan( '12345' ).must_equal [Pair.new( :number, 12_345 )]
    end

    it 'should be able to count bears' do
      Lexicon.scan( '1 bear' )
        .must_equal [Pair.new( :number, 1 ), Pair.new( :noun, 'bear' )]
    end
  end

  describe 'errors' do
    it 'should return error for unrecognised words' do
      Lexicon.scan( 'wibble' ).must_equal [Pair.new( :error, 'wibble' )]
      Lexicon.scan( 'babelfish' ).must_equal [Pair.new( :error, 'babelfish' )]
    end
  end
end
