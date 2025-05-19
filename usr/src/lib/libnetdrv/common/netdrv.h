#ifndef _NETDRV_H
#define _NETDRV_H

#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif

int netdrv_open(void);
int netdrv_send(const char *msg, char *buf, size_t buflen);

#ifdef __cplusplus
}
#endif

#endif /* _NETDRV_H */
