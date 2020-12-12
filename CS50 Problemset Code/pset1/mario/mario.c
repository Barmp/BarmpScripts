/*Project for CS50; PSET1 Mario*/
/*Written by Greg Malone, Jan 12, 2014*/
/*Notes:  I've used while loops like this in Python, glad to see they work the same way here.*/

#include <cs50.h>
#include <stdio.h>

int pyramid(a) {    // Broke out the pyramid building into it's own function to ease testing.
    int i,x,y;
    for (i = 0; i < a; i++) {           // For each line of height
        for (x = i + 1; x < a; x++) {   //Print one fewer spaces than current line height
            printf(" ");
        }
        for (y = 0; y <= i; y++) {      //Followed by one hash per line depth
            printf("#");
        }
        printf("#\n");                  //Ending with a hash and new line.
    }
    return 0;                           
}

int main(void) {
    while(1) {      // loop until returned.
        printf("Height: ");
        int py_high = GetInt();
        if (py_high < 0 || py_high > 23) {     
                                                    //If the number is out of scope it will do nothing and restart the loop.
        }
        else {
        pyramid(py_high);                           //If the number is in scope it calls the above Pyramid function.
        return 0;
        }
    }
}


