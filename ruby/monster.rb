require './formatters'

# A monster for an adventure
class Monster
  include Formatters

  INJURED = %w{staggering reeling injured}

  attr_reader :name, :health

  def self.load( str )
    m = /(?<name>.*)\s(?<health>\d+)/.match str
    new( m[:name], m[:health].to_i )
  end

  def initialize( name, points )
    @name   = titlecase( name )
    @full_health = @health = points
  end

  def indefinite_name
    indefinite name
  end

  def hit( amount )
    amount  = amount.power if amount.respond_to? :power
    @health = [0, health - amount].max
  end

  def heal
    @health += 1 unless dead? || health == @full_health
  end

  def dead?
    health == 0
  end

  def to_s
    name
  end
end
