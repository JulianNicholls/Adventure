require 'minitest/autorun'
require 'minitest/pride'

require './sentence'

describe Sentence do
  it 'should build a sentence from three Pairs' do
    words = [Pair.new(:noun, 'player'),
             Pair.new(:verb, 'go'),
             Pair.new(:direction, 'north')]
    Sentence.new(*words).to_s.must_equal 'player go north'
  end
end
