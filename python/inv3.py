import inventory
# from inventory import *

initial = ('Sword of Mord', 'Rope of Hope', 'Potion of Motion',
            'Racket Jacket', 'Doublet Goblet')

find = ('Chest from Brest', 'Jewels from King Raoul')

def print_inv(inv):
    print('inventory:', inv.str(), '({0})'.format(inv.length()))

print("""
Inventory Test 3 (Inventory Class)
==================================
""")

# print('dir(inventory):', dir(inventory))    # Only works with import...

inv = inventory.Inventory()     # Required with import inventory
# inv = Inventory()             # Works with from...

for i in initial:       # Do the work of add_multiple
    inv.add(i)

print_inv(inv)

print('\nAdding chance find in one go')
inv.add_multiple(find)
print_inv(inv)

print('\nUsing the Jewels by name to buy Gold')
inv.use('Jewels from King Raoul')
inv.add('Gold from Mold')
print_inv(inv)

print('\nUsing the Gold by position to buy Silver')
inv.use(6)
inv.add('Silver from Nineveh')
print_inv(inv)
