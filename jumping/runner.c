#include <stdio.h>

int jump_test(int a, int b);

int main()
{
    int rc;

    // Expect 1337 (10 > 5)
    rc = jump_test(10, 5);
    printf("%d\n", rc);
    
    // Expect (5 < 10)
    rc = jump_test(5, 10);
    printf("%d\n", rc);

    // Expect 42 (==)
    rc = jump_test(3, 3);
    printf("%d\n", rc);

    return 0;
}
