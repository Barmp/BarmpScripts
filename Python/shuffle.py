###############################################################
#
# Function to shuffle two lists together, emulating a riffle
#   shuffle like a deck of cards that does not perfectly 
#   interlace the list.
# 
# Written by Greg Malone - August 2013
#
###############################################################

from random import randint


def shuffle(a, b):
    '''Shuffles two lists together via a riffle shuffle, with 1 or 2 items from
    either list per pass'''
    c = []
    while len(a):
        c.append(a.pop())
        if (len(a) is not 0) and randint(0,1): c.append(a.pop())
        if (len(b) is not 0):
            c.append(b.pop())
            if randint(0,1) and (len(b) is not 0): c.append(b.pop())
    while len(b):
        c.append(b.pop())
    return c

'''Test Code:
a = ["kh", "kd", "ks", "kc", "qh", "qd", "qs", "qc", "jh", "jd", "js", "jc"]
b = ["10h", "9h", "8h", "7h", "6h", "5h", "4h"]
print shuffle(a, b)
'''