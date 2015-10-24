# Formatters for text
module Formatters
  module_function

  def indefinite(item)
    "#{article(item)} #{item}"
  end

  def indefinite_capital(item)
    "#{article(item).capitalize} #{item}"
  end

  def titlecase(text, minor_words = [])
    minor_words.map(&:downcase)

    text.split.map.with_index do |word, idx|
      word.downcase!

      word.capitalize! unless idx > 0 && minor_words.include?(word)

      word
    end.join ' '
  end

  # :reek:TooManyStatements   I don't think it's too much
  def list_contents(list)
    case list.size
    when 0  then return ''
    when 1  then return indefinite_capital(list.first)

    else # There's at least two so we take off the last one and prepend 'and'
      last = " and #{indefinite list.pop}"

      (list.map.with_index do |item, idx|
        idx == 0 ? indefinite_capital(item) : indefinite(item)
      end.join ', ') + last
    end
  end

  def article(item)
    'AEIOU'.include?(item[0].upcase) ? 'an' : 'a'
  end
end
