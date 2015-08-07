require './formatters'

# Storage for an inventory of items, both for what an adventurer is carrying
# and for the contents of a room.
class Inventory
  include Formatters

  def initialize( *items )
    @items = []
    add( *items ) if items
  end

  def add( *items )
    items.each { |item| @items << storable( item ) }
  end

  def contents
    list_contents @items.map( &:to_s )
  end

  def size
    @items.size
  end

  # Drop means remove from the inventory, and it may also be added to a room,
  # hence why the dropped item is returned here
  def drop( thing )
    return nil unless got_a? thing

    thing.downcase!
    idx = @items.find_index { |item| item.downcase.index( thing ) }
    @items.delete_at( idx )
  end

  def got_a_sword?
    got_a? 'sword'
  end

  def got_a_key?
    got_a? 'key'
  end

  def got_a?( thing )
    thing.downcase!
    @items.any? { |item| item.downcase.index( thing ) }
  end

  private

  # If it's an item, it can just be stored
  # A bare string item name is titlecased before storage
  def storable( item )
    return item if item.respond_to?( :name )

    titlecase( item )
  end
end
