require 'minitest/autorun'
require 'minitest/pride'

require './parser'

describe Parser do
  it 'should be able to build a NVO phrase' do
    words = Lexicon.scan 'bear hit princess'
    parser = Parser.new(words)
    parser.parse_sentence.to_s.must_equal 'bear hit princess'
  end

  it 'should be able to build a player-centric phrase' do
    words = Lexicon.scan 'go north'
    parser = Parser.new(words)
    parser.parse_sentence.to_s.must_equal 'player go north'
  end

  it 'should be able to build a phrase from just a direction' do
    words = Lexicon.scan 'up'
    parser = Parser.new(words)
    parser.parse_sentence.to_s.must_equal 'player go up'
  end

  it "should be able to ignore 'stop' words" do
    words = Lexicon.scan 'go to the west'
    parser = Parser.new(words)
    parser.parse_sentence.to_s.must_equal 'player go west'
  end

  it 'should be able to throw out a bad phrase' do
    words = Lexicon.scan 'princess bear'
    parser = Parser.new(words)
    -> { parser.parse_sentence }.must_raise RuntimeError
  end
end
