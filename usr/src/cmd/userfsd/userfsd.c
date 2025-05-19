#include <door.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static void userfsd_handler(void *, char *, size_t, door_desc_t *, uint_t);
static int door_fd;

static void
userfsd_handler(void *cookie, char *argp, size_t arg_size, door_desc_t *dp, uint_t ndesc)
{
    const char *msg = "userfsd: not implemented";
    (void) door_return((char *)msg, strlen(msg) + 1, NULL, 0);
}

int
main(int argc, char **argv)
{
    door_fd = door_create(userfsd_handler, NULL, 0);
    if (door_fd < 0) {
        perror("door_create");
        return 1;
    }

    if (fattach(door_fd, "/var/run/userfsd_door") < 0) {
        perror("fattach");
        return 1;
    }

    printf("userfsd running\n");
    for (;;) {
        pause();
    }
    return 0;
}
