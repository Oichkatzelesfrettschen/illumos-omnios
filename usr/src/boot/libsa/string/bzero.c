#include <sys/cdefs.h>
__FBSDID("$FreeBSD$");

/**
 * @file bzero.c
 * @brief Thin wrapper to build bzero using the memset implementation.
 */
#define	BZERO
// Build bzero from the shared memset implementation.
#include "memset.c"
