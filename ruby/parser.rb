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

  def match(expected)
    word = @words.shift

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
    when :verb  then  return parse_subject(Lexicon.player) # player phrase

    when :direction # Movement, just 'north' or 'up'
      return Sentence.new(Lexicon.player, Lexicon.go, match(:direction))
    end

    fail "Must start with subject, object, or verb not: #{start}"
  end
end
