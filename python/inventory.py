from list_util import comma_and

class Inventory:
    "Inventory class for a notional adventure game."

    def __init__(self, initial_item = None):
        "Initialise with an optional item"

        self.items = []

        if initial_item:
            self.items.append(initial_item)

    def length(self):
        "Return the number of items"
        return len(self.items)


    def add(self, item):
        "Add a new item"
        self.items.append(item)


    def add_multiple(self, item_list):
        "Add a new set of items"
        for i in item_list:
            self.items.append(i)

    def drop(self, item):
        """Use or drop an item from the inventory by index, name, or word
        and return its exact name for further use."""
        found = ''

        if type(item) == int:
            found = self.items[item]
            del self.items[item]
        elif item in self.items:
            found = item
            self.items.remove(item)
        else:   # We'll have to look for it
            idx = self.__item_index(item)
            if idx != -1:
                found = self.items[idx]
                del self.items[idx]

        return found

    def has_a_sword(self):
        "return whether a sword is held"
        return self.has_a('sword')


    def has_a_key(self):
         "return whether a key is held"
         return self.has_a('key')


    def has_a(self, item):
        "return whether a given item is held"
        return self.__item_index(item) != -1


    def __item_index(self, word):
        "Return the index of an item that contains the passed word"
        for i in range(len(self.items)):
            if word in self.items[i].lower():
                return i

        return -1


    def __str__(self):
        if len(self.items) > 0:
            return comma_and(self.items)
        else:
            return 'Nothing'
