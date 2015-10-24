# Sentence analyser for user input, builds a Noun Verb Object phrase
class Sentence
  def initialize(subject, verb, object)
    @subject  = subject.word
    @verb     = verb.word
    @object   = object.word
  end

  def to_s
    "#{@subject} #{@verb} #{@object}"
  end
end
