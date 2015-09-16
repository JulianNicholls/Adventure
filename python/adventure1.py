from inventory  import *
from room       import *


def take(room, nouns):
    for i in nouns:
        item = room.take(i)

        if item:
            print('You pick up the', item, 'and stash it in your bag of holding.')
            the_inv.add(item)
        elif i != 'and':
            print("There's no", i, 'to take here.')


def drop(room, nouns):
    for i in nouns:
        if the_inv.has_a(i):
            item = the_inv.drop(i)
            room.drop(item)
            print("You drop the", item)
        elif i != 'and':
            print("You don't have a", i)


def print_inventory():
    print('You are carrying', the_inv)


def attack(room, nouns):
    if room.monster_name().lower() == nouns[0]:
        if room.monster_health() == 'dead':
            print("It's already dead, let it rest!")
            return

        if 'sword' in nouns:
            if the_inv.has_a_sword():
                print('You hit the', room.monster_name(), 'with the sword and it falls down dead.')
                room.kill_monster()
                return
            else:
                print("You don't have a sword.")

        room.attack_monster()
        print('You punch the', room.monster_name(), 'and it staggers,', room.monster_health())
    else:
        print("There's no", nouns[0], 'here.')


print("""
Text Adventure
==============
""")

room1   = Room('a dark room', 'NSE', 'Balrog', ('Blue Key', 'Magic Sword'))
the_inv = Inventory()

text = ''

while text != 'quit':
    print('\n\nYou are in', room1)

    print('\nWhat would you like to do? ', end = '')
    text = input().strip().lower()
    verb, *nouns = text.split()
    print()

    if verb == 'take' or verb == 'get':
        take(room1, nouns)
    elif verb == 'drop' or verb == 'discard':
        drop(room1, nouns)
    elif verb.startswith('inv'):
        print_inventory()
    elif verb == 'kill' or verb == 'attack':
        attack(room1, nouns)
    elif verb != 'quit':
        print('Huh?!', text, "makes no sense, young 'un")

print('Goodbye young adventurer')
