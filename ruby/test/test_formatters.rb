require 'minitest/autorun'
require 'minitest/pride'

require './formatters'

describe Formatters do
  describe '#indefinite' do
    it 'should use a (lower case) for consonantally started items' do
      Formatters.indefinite('Blue Ball').must_equal 'a Blue Ball'
      Formatters.indefinite('Funny Face').must_equal 'a Funny Face'
      Formatters.indefinite('Mixed Grill').must_equal 'a Mixed Grill'
      Formatters.indefinite('Shiny Tuba').must_equal 'a Shiny Tuba'
      Formatters.indefinite('Zany Zebra').must_equal 'a Zany Zebra'
    end

    it 'should use an (lower case) for vowelly started items' do
      Formatters.indefinite('Articulate Aardvark')
        .must_equal 'an Articulate Aardvark'
      Formatters.indefinite('Eggplant').must_equal 'an Eggplant'
      Formatters.indefinite('Inestimable Ibex').must_equal 'an Inestimable Ibex'
      Formatters.indefinite('Opened Orifice').must_equal 'an Opened Orifice'
      Formatters.indefinite('Untried Usurper').must_equal 'an Untried Usurper'
    end

    it 'should not care about the case of the first character of the noun' do
      Formatters.indefinite('shoe').must_equal 'a shoe'
      Formatters.indefinite('arm').must_equal 'an arm'

      Formatters.indefinite('Shoe').must_equal 'a Shoe'
      Formatters.indefinite('Arm').must_equal 'an Arm'
    end
  end

  describe '#indefinite_capital' do
    it 'should capitalise a or an' do
      Formatters.indefinite_capital('Articulate Aardvark')
        .must_equal 'An Articulate Aardvark'
      Formatters.indefinite_capital('Funny Face').must_equal 'A Funny Face'
      Formatters.indefinite_capital('Inestimable Ibex')
        .must_equal 'An Inestimable Ibex'
      Formatters.indefinite_capital('Shiny Tuba').must_equal 'A Shiny Tuba'
      Formatters.indefinite_capital('Untried Usurper')
        .must_equal 'An Untried Usurper'
    end
  end

  describe '#titlecase' do
    it 'should render simply in title case' do
      Formatters.titlecase('blue blood').must_equal 'Blue Blood'
      Formatters.titlecase('GREEN DRAGON').must_equal 'Green Dragon'
      Formatters.titlecase('ReD PoStBoX').must_equal 'Red Postbox'
    end

    it 'should be able to ignore words' do
      Formatters.titlecase('the cat in the hat').must_equal 'The Cat In The Hat'
      Formatters.titlecase('THE CAT IN THE HAT', %w(the in))
        .must_equal 'The Cat in the Hat'

      Formatters.titlecase('THE CAT IN THE HAT', %w(The IN))
        .must_equal 'The Cat in the Hat'
    end
  end

  describe '#list_contents' do
    it 'should return no items correctly' do
      Formatters.list_contents([]).must_equal ''
    end

    it 'should return one item correctly' do
      Formatters.list_contents(['Green Dragon']).must_equal 'A Green Dragon'
      Formatters.list_contents(['Blue Box']).must_equal 'A Blue Box'
    end

    it 'should return two items correctly' do
      Formatters.list_contents(['Green Dragon', 'Blue Box'])
        .must_equal 'A Green Dragon and a Blue Box'
    end

    it 'should return three or more items correctly' do
      Formatters.list_contents(['Green Dragon', 'Blue Box', 'Orangutan'])
        .must_equal 'A Green Dragon, a Blue Box and an Orangutan'

      Formatters.list_contents(
        ['Green Dragon', 'Blue Box', 'Orangutan', 'Elongated Armrest']
      ).must_equal(
        'A Green Dragon, a Blue Box, an Orangutan and an Elongated Armrest'
      )
    end
  end
end
