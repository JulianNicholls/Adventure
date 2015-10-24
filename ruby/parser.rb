require './lexicon'
require './sentence'

# Sentence Parser
class Parser
  def initialize(word_list)
    @words = word_list
  end

  def peek
    @words.first.token
  rescue
    nil
  end

  # :reek:ControlParameter   expected is really the point
  # Obviously, it could be split out to match_verb, match_noun etc, but that
  # makes no sense to me.
  def match(expected)
    word = first_word

    word.token == expected ? word : nil
  rescue
    nil
  end

  def skip(token)
    match(token) while peek == token
  end

  def parse_verb
    skip(:stop)

    return match(:verb) if peek == :verb

    fail 'Expected a Verb.'
  end

  def parse_object
    skip(:stop)
    next_word = peek

    return match(:noun)      if next_word == :noun
    return match(:direction) if next_word == :direction

    fail 'Expected a Noun or Direction.'
  end

  def parse_subject(subj)
    verb = parse_verb
    obj  = parse_object

    Sentence.new(subj, verb, obj)
  end

  def parse_sentence
    skip(:stop)

    start = peek

    case start
    when :noun  then  return parse_subject(match(:noun)) # Complete NVO phrase
    when :verb  then  return parse_subject(player)       # player phrase

    when :direction # Movement, just 'north' or 'up'
      return Sentence.new(player, Lexicon.go, match(:direction))
    end
  end

  private

  def first_word
    @words.shift
  end

  def player
    @player ||= Lexicon.player
  end
end
