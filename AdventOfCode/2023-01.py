## Day 1, Part 1 successful.
## Day 1, Part 2 failed.
## The value for my solution is too low, there is probably a corner case I've missed that is giving me the wrong values.

import re #regular expressions for the searchtext function.
total = 0

def getdigits(v):
    count = 0
    firstdigit = ""
    firstindex = 0
    seconddigit = ""
    secondindex = 0
    for i in v: #for each character in string
        if i.isdecimal():
            if (firstdigit == ""): #set the first and second digit the same
                                # as this may be the only digit in the string.
                firstdigit = i
                firstindex = count
                seconddigit = i
                secondindex = count
            else: 
                seconddigit = i #set only the second digit for any further nunbers found.
                secondindex = count
        count += 1
    # Part 1 solution only required me to return the digits.
    # return(int(firstdigit + seconddigit))

    dict = {"firstdigit": firstdigit, "firstindex": firstindex, "seconddigit": seconddigit, "secondindex": secondindex}
    return dict

def searchtext(v, i, j): #pass in the full string as above, then the firstindex and secondindex values
    firstsection = v[:i] #grab the start of string up to the index of the first numeral
    secondsection = v[j:] #grab the end of the string from the second numeral to the end
    firstdigit = "none"
    firstindex = 10000
    seconddigit = "none"
    secondindex = -1

    ## write if/then statements for each numeral word (one, two, three...)?
    ## then check if they're earlier in firstsection, or later in secondsection than any current matches?
    values = ("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
    numbers = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")

    count = 0
    for value in values:
        x = re.search(value, firstsection)
        
        if x and x.span()[0] < firstindex:
            firstindex = x.span()[0]
            firstdigit = numbers[count]
            #print(f"  A {value} was found at {x.span()[0]}")

        if len(secondsection) > 1:
            l = -1
            secondstring = secondsection[l:]
            while len(secondstring) < len(secondsection):
                y = re.search(value, secondstring)
        
                if y and y.span()[0] > secondindex: 
                    secondindex = y.span()[0]
                    seconddigit = numbers[count]
                    #print(f"  A {value} was found at {y.span()[0]}")
                    break
                elif y: 
                    #print(f"  A {value} was found at {y.span()[0]} and discarded")
                    break
                else:
                    l -= 1
                    secondstring = secondsection[l:]

        count += 1

    dict = {
        "firstdigit": firstdigit, 
        "firstindex": firstindex, 
        "seconddigit": seconddigit, 
        "secondindex": secondindex
    }
    return dict


with open("/home/barmp/Projects/AOC2023/01_input.txt") as file:
    while line := file.readline():
        # Part 1 solution only required me to sum up the value of first and second digits
        # total += getdigits(line)

        digits = getdigits(line)
        text = searchtext(line, digits['firstindex'], digits['secondindex'])
        output = ""
        #print(digits)
        #print(text)

        if (text['firstdigit'] != "none"):

            output += text['firstdigit']
        else:
            output += digits['firstdigit']

        if (text['seconddigit'] != "none"):
            output += text['seconddigit']
        else:
            output += digits['seconddigit']

        #print(f"{line} --> {output}")
        total += int(output)
        #print(total)

    print(total)
