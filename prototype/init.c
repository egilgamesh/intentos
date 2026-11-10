#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>

static void ensure_dir(const char *path) { if (mkdir(path, 0755) && errno != EEXIST) perror(path); }
int main(void) {
  ensure_dir("/proc"); ensure_dir("/sys"); ensure_dir("/dev");
  mount("proc", "/proc", "proc", 0, NULL);
  mount("sysfs", "/sys", "sysfs", 0, NULL);
  mount("devtmpfs", "/dev", "devtmpfs", 0, NULL);
  int fd = open("/dev/console", O_RDWR);
  if (fd >= 0) { dup2(fd,0); dup2(fd,1); dup2(fd,2); if(fd>2) close(fd); }
  puts("INTENTOS_BOOT_OK");
  puts("IntentOS 0.1 - bootable Linux kernel developer preview");
  puts("Commands: help, status, uname, reboot, poweroff");
  fflush(stdout);
  char line[128];
  for (;;) {
    fputs("intentos> ", stdout); fflush(stdout);
    if (!fgets(line,sizeof(line),stdin)) { clearerr(stdin); sleep(1); continue; }
    line[strcspn(line,"\r\n")] = 0;
    if (!strcmp(line,"help")) puts("help status uname reboot poweroff");
    else if (!strcmp(line,"status")) puts("IntentOS kernel running; IntentMind not installed");
    else if (!strcmp(line,"uname")) system("/bin/uname -a");
    else if (!strcmp(line,"reboot")) { sync(); reboot(RB_AUTOBOOT); }
    else if (!strcmp(line,"poweroff")) { sync(); reboot(RB_POWER_OFF); }
    else if (*line) puts("Unknown command. Type help.");
  }
}
