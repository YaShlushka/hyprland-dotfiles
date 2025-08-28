# System calls linux

|Number(rax)|System call|Appointment										 |arguments										|
|:---------:|:---------:|:----------------------------------------:|:-----------------------------------:|
|0				|read			|Read from file									 |fd, buf, count								|
|1				|write		|Write to file/console							 |fd, buf, count								|
|2				|open			|Open file											 |filename, flags, mode						|
|3				|close		|Close file											 |fd												|
|4				|stat			|File info											 |filename, statbuf							|
|5				|fstat		|File info by descriptor						 |fd, statbuf									|
|6				|lstat		|Sym.link info										 |filename, statbuf							|
|9				|mmap			|Memory mapping									 |addr, length, prot, flags, fd, offset|
|39			|get_pid		|Get the PID of the current process			 |none											|
|41			|socket		|Creating a socket								 |family, type, protocol					|
|57			|fork			|Clone the process								 |none											|
|59			|execve		|Starting a new process							 |filename, argv, enpv						|
|60			|exit			|Terminate the process							 |status											|
|61			|wait4		|Wait the process									 |pid, status, options, rusage			|
|63			|uname		|Get system info									 |buf												|
|80			|chdir		|Change directory									 |path											|
|231			|exit_group	|Terminate the process and all it's threads|status											|

# The order of arguments in registers

system call number - rax

1st argument - rdi

2nd argument - rsi

3rd argument - rdx

4th argument - r10

5th argument - r8

6th argument - r9

# file descriptor types

0. stdin
1. stdout
2. stderr