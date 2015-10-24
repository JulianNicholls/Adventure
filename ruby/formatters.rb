# Formatters for text
module Formatters
  module_function

  def indefinite(text, capital = false)
    article = 'AEIOU'.include?(text[0].upcase) ? 'an' : 'a'
    article.capitalize! if capital
    "#{article} #{text}"
  end

  def titlecase(text, minor_words = [])
    minor_words.map(&:downcase)

    text.split.map.with_index do |word, idx|
      word.downcase!

      word.capitalize! unless idx > 0 && minor_words.include?(word)

      word
    end.join ' '
  end

  def list_contents(list)
    return '' if list.size == 0
    return indefinite(list.first, :capital) if list.size == 1

    # Now, there's at least two items so we take off the last one and prepend
    # 'and'

    last = " and #{indefinite list.pop}"

    (list.map.with_index { |item, idx| indefinite(item, idx == 0) }
    .join ', ') + last
  end
end
