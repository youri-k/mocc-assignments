#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
    char* test;

    while(test != NULL){
      test = malloc(4 * 1024);  
    } 

    printf("Malloc failed\n");

    return 0;
}