inventory = [       # Mutable List of Items
    'Sword of Mord', 'Rope of Hope', 'Potion of Motion', 'Racket Jacket', 
    'Doublet Goblet'
]

find = [            # Mutable Another List of Items
    'Chest from Brest', 'Jewels from King Jules'
]

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
Inventory Test 2 (Lists)
========================
""" )

print( 'inventory =', inventory, '(print)' )
print_inv( inventory )

inv  = inventory        # Actually identical (because mutable?)
inv2 = inventory[:]     # Explicit copy

print_inv( inv, 'inv' )
print_inv( inv2, 'inv2' )

print( '\nAdding the chance find to inv...' )
inv += find     # Effectively inv (and inventory) is extended with find

print_inv( inventory )
print_inv( inv, 'inv' )     # These are still equal for a List
print_inv( inv2, 'inv2' )

print( '\nSwapping the Jewels for Gold' )
inventory[-1] = 'Gold from Mold'

print_inv( inventory )
print_inv( inv, 'inv' )     # These are still equal for a List
print_inv( inv2, 'inv2' )
