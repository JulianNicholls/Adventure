def comma_and(str_list):
    """
    Returns a list of items formatted with commas, with the word 'and' before
    the last one.

    Works with both lists and tuples.
    """
    strs = list(str_list)     # Take a list copy so we can manipulate the items

    if len(strs) == 0:        # Zero items, nothing to do
        return ''
    elif len(strs) == 1:      # One item, just return it
        return strs[0]

    # Cut off the last item and prepend 'and' to it.

    end = ' and ' + strs[-1]
    del strs[-1]

    return (', '.join(strs)) + end


if __name__ == '__main__':
    print "test: []\t\t", comma_and([])
    print "test: a:\t\t", comma_and(['alpha'])
    print "test: a, b:\t\t", comma_and(['alpha', 'bravo'])
    print "test: a, b, c:\t\t", comma_and(['alpha', 'bravo', 'charlie'])
    print "test: a, b, c, d:\t", comma_and(['alpha', 'bravo', 'charlie', 'delta'])

    tuple = ('can', 'not', 'change', 'me')
    print "\ntest: 4 element tuple:\t", comma_and(tuple)
    print "test: tuple after:\t", tuple

    list1 = ['must', 'not', 'change', 'me']
    print "\ntest: 4 element list:\t", comma_and(list1)
    print "test: list after:\t", list1
