#include <stdio.h>

// External function defined assembly. Declare here for
// the c compiler. A better place for this would be in a
// header, but this works as well.
int add_one(int);

int main()
{
    int ret;

    ret = add_one(1336);
    printf("%d\n", ret);

    ret = add_one(41);
    printf("%d\n", ret);

    return 0;
}
