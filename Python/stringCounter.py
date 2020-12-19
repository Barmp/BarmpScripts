###############################################################
#
# String_counter function to list number of Uppercase & Lowercase 
#   letters, digits, and non-alphanumeric characters in a string.
# 
# Written by Greg Malone - July 2014
#
###############################################################

if __name__ == "__main__":
  user = raw_input("Enter something: " )
  string_counter(user)

def string_counter(string):
  if (type(user) == str):
    a = 0
    b = 0
    c = 0
    d = 0
    print "Input was a string"
    print "Length of input = ", len(user)
    for x in user:
      if x.isupper(): a = a + 1
      elif x.islower(): b = b + 1
      elif x.isdigit(): c = c + 1
      else: d = d + 1
    print "Num upper: ", a
    print "Num lower: ", b
    print "Num digit: ", c
    print "Num other: ", d
