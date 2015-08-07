inventory = (       # Immutable Tuple of Items
    'Sword of Mord', 'Rope of Hope', 'Potion of Motion', 'Racket Jacket', 
    'Doublet Goblet'
)

find = (            # Another Immutable Tuple of items
    'Chest from Brest', 'Jewels from King Jules'
)

def print_inv( inv, name = 'inventory' ):
    print( name + ':\n ', end = ' ' )
    left = 2
    for i in inv:
        left += len(i)
        if left > 78:
            print( '\n ', end = ' ' )
            left = 2
            
        print( i, end = ', ' )

    print( '\n' )

print( """
Inventory Test 1 (Tuples)
=========================
""" )

print( 'inventory =', inventory, '(print)' )
print_inv( inventory )

inv = inventory     # Still identical, I think?

print_inv( inv, 'inv' )

print( '\nAdding the chance find to inv...' )
inv += find     # effectively inv = new Tuple(inv+find) 

print_inv( inv, 'inv' )     # These are no longer equal for a Tuple
print_inv( inventory )
