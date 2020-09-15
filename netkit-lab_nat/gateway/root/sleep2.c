#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

int alarm_time;
char *pid_file;

void reset_alarm(int signum) {
   alarm (alarm_time);
   signal (SIGUSR1, reset_alarm);
}

void done() {
   exit(0);
}

int main(int argc, char* argv[]) {
   int fd;
   char pid[10];
   alarm_time = atoi(argv[1]);
   pid_file = argv[2];

   /* Write PID to file */
   fd = creat (pid_file, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
   sprintf (pid, "%i", getpid());
   write (fd, pid, strlen(pid));
   close (fd);

   alarm (alarm_time);
   signal (SIGUSR1, reset_alarm);
   signal (SIGALRM, done);
   while (1) pause();
}
