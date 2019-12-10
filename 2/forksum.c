#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

#define BUF_SIZE 256

int parent(int start, int end);
int create_child(int start, int end);

int main(int argc, char* argv[])
{
    if (argc != 3)
    {
        printf("error: wrong number of arguments\n");
        return -1;
    }

    int start = atoi(argv[1]);
    int end = atoi(argv[2]);

    int x = 0;

    if (start == end)
    {        
        x = start;
    }
    else
    {
        x = parent(start, end);
    }

    printf("The sum is %i", x);
    return 0;
}

int parent(int start, int end)
{
    // the pipe buffers from which the parent reads the result of its child    
    char* readbuffer1;
    readbuffer1 = calloc(BUF_SIZE, sizeof(char));
    char* readbuffer2;
    readbuffer2 = calloc(BUF_SIZE, sizeof(char));

    //perror("create child for range %i - %i\n", start, (start + end) / 2);
    int x = create_child(start, (start + end) / 2);
    //perror("create child for range %i - %i\n", (start + end) / 2 + 1, end);
    int y = create_child((start + end) / 2 + 1, end);

    read(x, readbuffer1, BUF_SIZE);
    read(y, readbuffer2, BUF_SIZE);
    close(x);
    close(y);
    return atoi(readbuffer1) + atoi(readbuffer2);
}

// returns read end of pipe
int create_child(int start, int end)
{    
    int fd[2]; // the two file descriptors for the pipe (pipe is basically a virtual file)

    if (pipe(fd) < 0) // try to open pipe
	{
		perror("error trying to open pipe using pipe(fd)");
		return -2;
	}

    pid_t pid; // process id that fork returns to indicate if success or not, and if in parent or child process
    int x, y;

    if ((pid = fork()) < 0) // create new child process
    {
        perror("error creating a new child process using fork()");
        return -3;
    }

    if (pid == 0)
    {
        if (start == end)
        {
            close(fd[0]);
            dup2(fd[1], STDOUT_FILENO); // write end of pipe is set to standard output stream
            printf("%i", start);
            close(fd[1]);
            exit(0);
        }
        else
        {
            close(fd[0]);
            dup2(fd[1], STDOUT_FILENO); // write end of pipe is set to standard output stream
            int t = parent(start, end);
            printf("%i", t);
            close(fd[1]);
            exit(0);
        }
    }
    else
    {
        close(fd[1]);  
        return fd[0];
    }
    
}