from list_util import comma_and
import monster

class Room:
    "Hold an adventure game room"

    __directions = {
        'n' : 'North',
        'e' : 'East',
        's' : 'South',
        'w' : 'West'
    }


    def __init__(self, desc, exits, monster_name = None, booty = []):
        "Initialise with a name, exits, monsters, and items"
        self.desc   = desc
        self.exits  = exits
        self.booty  = list(booty)

        if monster_name:
            self.__monster = monster.Monster(monster_name)
        else:
            self.__monster = None


    def take(self, item_name):
        "Take an item from the room, if found"
        for b in self.booty:
            if item_name in b.lower():
                self.booty.remove(b)
                return b.replace(' that you dropped here', '')

        return None


    def drop(self, item_name):
        "Hold an item that the adventurer drops"
        self.booty.append(item_name + ' that you dropped here')


    def monster_name(self):
        "Return the monster's name"
        if self.__monster:
            return self.__monster.name()


    def monster_health(self, no_alive = True):
        "Return how the monster is feeling"
        if self.__monster:
            return self.__monster.health_desc(no_alive)


    def kill_monster(self):
        "Kill the monster"
        if self.__monster:
            self.__monster.kill()


    def attack_monster(self):
        "Attack the monster, and kill it if it's already wounded"
        if self.__monster:
            self.__monster.attack()


    def __str__(self):
        "Summarise the room contents"

        dirs = [Room.__directions[d.lower()] for d in self.exits]

        text =  '{0}.\nExits are to {1}\n'.format(self.desc, comma_and(dirs))

        if self.__monster:
            text += 'A {0} {1}'.format(self.monster_health(), self.monster_name())

            if self.monster_health() == 'dead':
                text += ' lies in a pool of lurid green blood.\n'
            else:
                text += ' blocks your way\n'

        if self.booty:
            text += 'On the floor: ' + comma_and(self.booty)

        return text

