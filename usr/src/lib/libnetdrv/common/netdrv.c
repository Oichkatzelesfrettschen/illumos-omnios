#include <door.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "netdrv.h"

static int door_fd = -1;

int
netdrv_open(void)
{
    door_fd = open("/var/run/netdrvd_door", O_RDONLY);
    return door_fd >= 0 ? 0 : -1;
}

int
netdrv_send(const char *msg, char *buf, size_t buflen)
{
    door_arg_t arg;
    if (door_fd < 0)
        return -1;
    arg.data_ptr = (void *)msg;
    arg.data_size = strlen(msg) + 1;
    arg.desc_ptr = NULL;
    arg.desc_num = 0;
    arg.rbuf = buf;
    arg.rsize = buflen;
    if (door_call(door_fd, &arg) < 0)
        return -1;
    return arg.rsize;
}
