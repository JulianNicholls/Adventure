require './formatters'
require './inventory'

# One room in the adventure
class Room
  include Formatters

  def initialize(desc, monster = nil, *items)
    @description = desc
    @monster     = monster
    @items       = Inventory.new(*items)
  end

  # Drop, in this case, adds to the room, i.e. drop the sword you were
  # carrying on the floor.
  def drop(*items)
    @items.add(*items)
  end

  def description
    "#{@description}. #{format_items} #{format_monster}"
  end

  def to_s
    description
  end

  private

  def format_items
    @items.size > 0 ? "\nYou can see #{@items.contents} here." : ''
  end

  def format_monster
    @monster ? "\nThere's #{@monster.indefinite_name} blocking your way." : ''
  end
end
