#ifndef _MY_STRLEN_H_INCLUDE_GUARD
#define _MY_STRLEN_H_INCLUDE_GUARD

#include <stddef.h>

size_t my_strlen(const char* str);

size_t my_strlen_safe(const char* str, size_t max_len);

#endif // _MY_STRLEN_H_INCLUDE_GUARD
