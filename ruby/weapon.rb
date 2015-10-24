require './formatters'

# A weapon for an adventure
class Weapon
  include Formatters

  attr_reader :name, :power

  def self.load(str)
    weapon = /(?<name>.*)\s(?<power>\d+)/.match str
    new(weapon[:name], weapon[:power].to_i)
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
