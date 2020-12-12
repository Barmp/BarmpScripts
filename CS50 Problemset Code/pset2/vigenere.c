#include <stdio.h>
#include <string.h>
#include <cs50.h>
#include <stdlib.h>
#include <ctype.h>



int main(int argc, string argv[]) {
    if (argc != 2) {            //Fail if no argument given, or too many arguments given.
        printf("An argument is required to proceed.  Please input a cyper value for the program to use.\ne.g. \"caesar 16\"\n");
        return 1;
        }
    int cypherLen = strlen(argv[1]);    //Evaluate attributes necessary and store them now 
    int cypher[cypherLen];              //so that we don't need to evaluate them many times
    int cypherPos = 0;                  //later on.
    for (int i = 0; argv[1][i] != '\0'; i++) {
        if (isalpha(argv[1][i]) == 0) {             //Fail if the argument (cypher) contains non-alphabetic characters.
            printf("Error: Only alphabetical characters accepted as cyper key.\n");
            return 1; 
            }
        cypher[i] = tolower(argv[1][i]) - 97;                       //Load the cypher array with the shift values.
        }
    string plaintext = GetString();
    
    for (int j = 0; plaintext[j] != '\0'; j++) {                  //iterate over string until the null terminator
        if (cypherPos >= cypherLen) { cypherPos = 0; }
        if (isalpha(plaintext[j])) {                                //check that value is a letter.
                if (isupper(plaintext[j])) {                        //sort uppercase letters from lowercase
                    if (plaintext[j] + cypher[cypherPos] > 'Z') {              //do we need to wrap the alphabet?
                        printf("%c", plaintext[j] + cypher[cypherPos] - 26);   //wrap the text around Z by subtracting 26 from the total
                    } else {
                        printf("%c", plaintext[j] + cypher[cypherPos]);        //simply add the values if we don't
                    }
                } else {
                    if (plaintext[j] + cypher[cypherPos] > 'z') {              //do the same for lowercase
                        printf("%c", plaintext[j] + cypher[cypherPos] - 26);
                    } else {
                        printf("%c", plaintext[j] + cypher[cypherPos]);
                    }
                }
        cypherPos = cypherPos + 1;
        } else {
            printf("%c", plaintext[j]);                             //prints any characters that are not letters
        }
    }
    printf("\n");
    return 0;
}

