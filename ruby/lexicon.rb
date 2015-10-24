# Parser for user input
class Lexicon
  Pair        = Struct.new(:token, :word)

  VERBS       = %w(go dig kill eat take drop stop open hit attack)
  DIRECTIONS  = %w(up down left right north south east west back)
  STOPS       = %w(in of and the from at it to)
  NOUNS       = %w(bear princess tower door cabinet)

  WORD_MAP    = {
    verb:       VERBS,
    direction:  DIRECTIONS,
    stop:       STOPS,
    noun:       NOUNS
  }

  def self.scan(text)
    pairs = []
    text.split.map(&:downcase).each do |word|
      tok  = token_type(word)
      word = word.to_i if tok == :number
      pairs << Pair.new(tok, word)
    end

    pairs
  end

  def self.token_type(word)
    return :number if /\A\d/.match word

    WORD_MAP.each do |tok, wordlist|
      return tok if wordlist.include? word
    end

    :error
  end

  # These two stand in where they are not specified explicitly
  # 'north' becomes 'player', 'go' 'north'

  def self.player
    Pair.new(:noun, 'player')
  end

  def self.go
    Pair.new(:verb, 'go')
  end
end
