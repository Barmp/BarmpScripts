/*Greg Malone*/
/*Written for CS50 2014; PSET1:Credit*/
/*Jan 12, 2014*/

#include <cs50.h>
#include <stdio.h>


int main(void)
{
    while (0) {
        printf("Give me your credit card number:  ");
        int x = GetInt();
        int lenx = length(x);

        switch (lenx) {
            case 13:
                printf("\nVisa");
                break;
            case 15: 
                printf("\nAMEX");
                break;
            case 16: 
                printf("\nVisa or Mastercard.");
                break;            
            default: 
                printf("\nCard is invalid.\n");
                break;
        }
            
    }

}


