/*Project for CS50; PSET1 Mario*/
/*Written by Greg Malone, Jan 12, 2014*/

#include <cs50.h>
#include <stdio.h>
#include <math.h>

int main(void) {
    printf("O hai!  ");
    while(1) {                                     //Loop until returned.
        printf("How much change is owed?\n");
        float change = GetFloat();
        if (change < 0.001) {  }                    //Negative numbers and values under 1 cent are filtered out and loop is restarted.                  
        else {
            int chg_owed = (int)round(change * 100);        //Convert the float into pennies, round it and cast it as an int.
            while (chg_owed > 0) {
                int coin_count = 0;
                while (chg_owed >= 25) {
                    coin_count = coin_count + 1;
                    chg_owed = chg_owed - 25;
                }
                while (chg_owed >= 10) {
                    coin_count = coin_count + 1;
                    chg_owed = chg_owed - 10;
                }        
                while (chg_owed >= 5) {
                    coin_count = coin_count + 1;
                    chg_owed = chg_owed - 5;
                }        
                while (chg_owed >= 1) {
                    coin_count = coin_count + 1;
                    chg_owed = chg_owed - 1;
                }        
                printf("%i\n", coin_count);
                return 0;
            }
        }
    }
    
    
    
}
