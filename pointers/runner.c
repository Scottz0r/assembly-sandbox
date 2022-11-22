#include <stdio.h>
#include <inttypes.h>

extern int basic_ptr(int32_t* p);
extern int char_arr_ptr(char* p);

int main()
{
    int rc;
    int32_t p_int;
    char buffer[4];

    // Test out the basic pointer example.
    p_int = 10;
    rc = basic_ptr(&p_int);
    printf("basic_ptr: %d (rc %d)\n", p_int, rc);

    // Test out the string pointer demo.
    rc = char_arr_ptr(buffer);

    // For safety sake, ensure the buffer is null terminated.
    if (buffer[3] != 0)
    {
        puts("Warning: buffer was not null terminated!\n");
        buffer[3] = 0;
    }

    printf("char_arr_ptr: %s (rc %d)\n", buffer, rc);

    return 0;
}
