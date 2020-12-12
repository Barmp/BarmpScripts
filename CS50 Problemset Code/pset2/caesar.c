#include <stdio.h>
#include <string.h>
#include <cs50.h>
#include <stdlib.h>
#include <ctype.h>



int main(int argc, string argv[]) {
    if (argc != 2) {            //fail if no argument given, or too many arguments given
        printf("An argument is required to proceed.  Please input a cyper value for the program to use.\ne.g. \"caesar 16\"\n");
        return 1;
        }
    else if (atoi(argv[1]) < 1) {               //fail if given a negative cypher value
        printf("Please input a non-negative integer value.\n");
        return 1;
        }
    string plaintext = GetString();
    int cypher = (atoi(argv[1]) % 26);
    for (int i = 0; plaintext[i] != '\0'; i++) {                    //iterate over string until the null terminator
        if (isalpha(plaintext[i])) {                                //check that value is a letter.
                if (isupper(plaintext[i])) {                        //sort uppercase letters from lowercase
                    if (plaintext[i] + cypher > 'Z') {              //do we need to wrap the alphabet?
                        printf("%c", plaintext[i] + cypher - 26);   //wrap the text around Z by subtracting 26 from the total
                    } else {
                        printf("%c", plaintext[i] + cypher);        //simply add the values if we don't
                    }
                } else {
                    if (plaintext[i] + cypher > 'z') {              //do the same for lowercase
                        printf("%c", plaintext[i] + cypher - 26);
                    } else {
                        printf("%c", plaintext[i] + cypher);
                    }
                }

        } else {
            printf("%c", plaintext[i]);                             //prints any characters that are not letters
        }
    }
    printf("\n");
    return 0;
}

