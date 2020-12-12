#include <cs50.h>
#include <stdio.h>
#include <math.h>

int main(void) {
    printf("Floating number:  ");
    float x = GetFloat();
    printf("%.50f\n", x);
    float y = roundf(x);
    printf("%.50f\n", y);
    int qq = (int)x;
    int z = (int)round(x * 100);
    printf("%i\n", z);
    printf("%f\n", x);
    printf("%i\n", qq);
    printf("finished\n");
}
