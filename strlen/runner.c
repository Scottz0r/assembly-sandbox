#include <stdio.h>
#include <string.h>

#include "my_strlen.h"

// Helper to define test data input entry.
#define TDI(x) {x, sizeof(x) - 1}

// Get the size of an array.
#define arr_size(x) (sizeof(x) / sizeof(x[0]))

// Holds an input string with its size.
typedef struct test_data_t
{
    const char* str;
    size_t expected;
} test_data_t;

void test_my_strlen()
{
    // Various test cases.
    const test_data_t test_values[] = 
    {
        TDI("This is a string."),
        TDI("    "),
    };

    size_t actual;

    printf("test_my_strlen\n");
    printf("--------------\n");

    for (int i = 0; i < arr_size(test_values); ++i)
    {
        
        actual = my_strlen(test_values[i].str);
        printf(
            "\"%s\" => (expected, actual) %lu, %lu\n",
            test_values[i].str,
            test_values[i].expected,
            actual);
    }

    // Test null pointer case.
    actual = my_strlen(NULL);
    printf("Null pointer (expect 0) => %lu\n", actual);
}

void test_my_strlen_safe()
{
    // Various test cases.
    const test_data_t test_values[] = 
    {
        TDI("This is a string."),
        TDI("    "),
    };

    char buffer[50];
    size_t actual;

    printf("test_my_strlen_safe\n");
    printf("-------------------\n");

    // Good cases.
    strcpy(buffer, test_values[0].str);
    actual = my_strlen_safe(test_values[0].str, sizeof(buffer));
    printf(
        "\"%s\" => (expected, actual) %lu, %lu\n",
        test_values[0].str,
        test_values[0].expected,
        actual);

    // Null case.
    actual = my_strlen_safe(NULL, sizeof(buffer));
    printf("Null pointer (expect 0) => %lu\n", actual);

    // No null terminator case.
    memset(buffer, 'A', sizeof(buffer));
    actual = my_strlen_safe(buffer, sizeof(buffer));
    printf("No string null terminator (expect %lu) => %lu\n", sizeof(buffer), actual);

    // Less size than buffer specified case.
    strcpy(buffer, "This is more than 10 characters for sure!");
    actual = my_strlen_safe(buffer, 10);
    printf("Smaller length specified (expect %lu) => %lu\n", 10ul, actual);

    // Zero length case.
    actual = my_strlen_safe(buffer, 0);
    printf("Zero length specified (expect %lu) => %lu\n", 0ul, actual);
}

int main()
{
    test_my_strlen();
    test_my_strlen_safe();

    return 0;
}
