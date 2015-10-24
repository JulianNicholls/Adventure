require './formatters'

# A weapon for an adventure
class Weapon
  include Formatters

  attr_reader :name, :power

  def self.load(str)
    m = /(?<name>.*)\s(?<power>\d+)/.match str
    new(m[:name], m[:power].to_i)
  end

  def initialize(name, power)
    @name   = titlecase(name)
    @power  = power
  end

  def indefinite_name
    indefinite name
  end

  def to_s
    name
  end
end
